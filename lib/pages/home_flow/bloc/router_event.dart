part of 'router_bloc.dart';

sealed class RouterEvent extends Equatable {
  const RouterEvent();

  @override
  List<Object> get props => [];
}

final class RouterUsersModelPassed extends RouterEvent {
  const RouterUsersModelPassed(this.user);
  final Users user;

  @override
  List<Object> get props => [user];
}