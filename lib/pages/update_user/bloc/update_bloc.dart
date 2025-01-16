import 'package:calculator_admin/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/repository/repository.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc({
    required FirebaseDatabaseRepository firebaseDatabase,
  }) : _databaseRepository = firebaseDatabase,
  super(const UpdateState()) {
    on<UserLoaded>(_onUserLoaded);
    on<UserUpdated>(_onUserUpdated);
    on<DatePickerChanged>(_onDatePickerChanged);
  }
  final FirebaseDatabaseRepository _databaseRepository;
  
  void _onUserLoaded(UserLoaded event, Emitter<UpdateState> emit) async {
    emit(state.copyWith(user: event.user));
  }

  void _onUserUpdated(UserUpdated event, Emitter<UpdateState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final now = DateTime.now();
      final datePick = state.date ?? now;
      
      if (!datePick.isAtSameMomentAs(now)) {
        await _databaseRepository.updateUsers(state.user.uid!, datePick);
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(status: Status.failure, message: "Expiration date required. Please select a date."));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
    emit(state.copyWith(status: Status.initial));
  }

  void _onDatePickerChanged(DatePickerChanged event, Emitter<UpdateState> emit) {
    emit(state.copyWith(date: event.date));
  }
}
