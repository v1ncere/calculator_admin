import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:calculator_admin/repository/repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required FirebaseAuthRepository firebaseAuth,
  })  : _firebaseAuthRepository = firebaseAuth,
  super(
    firebaseAuth.currentUser.isNotEmpty
    ? AppState(status: AppStatus.authenticated, user: firebaseAuth.currentUser)
    : const AppState(status: AppStatus.unauthenticated)
  ) {
    on<AppUserChanged>(_onAppUserChanged);
    on<AppLogoutRequested>(_onAppLogoutRequested);
    _streamSubscription = _firebaseAuthRepository.user.listen((user) => add(AppUserChanged(user)));
  }
  final FirebaseAuthRepository _firebaseAuthRepository;
  late final StreamSubscription<User> _streamSubscription;

  // app user changed
  void _onAppUserChanged(AppUserChanged event, Emitter<AppState> emit) async {
    try {
      if (_isUserValid(event.user)) {
        emit(state.copyWith(status: AppStatus.authenticated, user: event.user));
      } else {
        emit(state.copyWith(status: AppStatus.unauthenticated));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // logout
  void _onAppLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_firebaseAuthRepository.logOut());
  }

  // check if user exists
  bool _isUserValid(User? user) => user != null && user.isNotEmpty;

  @override
  Future<void> close() async {
    _streamSubscription.cancel();
    return super.close();
  }
}
