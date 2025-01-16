import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/repository/repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required FirebaseAuthRepository firebaseAuth,
  })  : _firebaseAuth = firebaseAuth,
  super(
    firebaseAuth.currentUser.isNotEmpty
    ? AppState(status: AppStatus.authenticated, user: firebaseAuth.currentUser)
    : const AppState(status: AppStatus.unauthenticated)
  ) {
    _streamSubscription = _firebaseAuth.user.listen((user) => add(AppUserChanged(user)));
    
    on<AppUserChanged>(_onAppUserChanged);
    on<AppLogoutRequested>(_onAppLogoutRequested);
  }
  final FirebaseAuthRepository _firebaseAuth;
  late final StreamSubscription<User> _streamSubscription;

  void _onAppUserChanged(AppUserChanged event, Emitter<AppState> emit) async {
    try {
      if (_isUserValid(event.user)) {
        emit(state.copyWith(status: AppStatus.authenticated, user: event.user));
      } else {
        emit(state.copyWith(status: AppStatus.unauthenticated));
      }
    } catch (_) {
      emit(state.copyWith(status: AppStatus.unauthenticated));
    }
  }

  void _onAppLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_firebaseAuth.logOut());
  }

  // CHECK IF USER EXIST
  bool _isUserValid(User? user) => user != null && user.isNotEmpty;

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
