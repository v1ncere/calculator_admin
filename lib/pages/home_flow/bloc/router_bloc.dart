import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/repository/repository.dart';

part 'router_event.dart';
part 'router_state.dart';

class RouterBloc extends Bloc<RouterEvent, RouterState> {
  RouterBloc() : super(const RouterState.initial()) {
    on<RouterUsersModelPassed>((event, emit) {
      emit(RouterState.updateUser(event.user));
    });
  }
}
