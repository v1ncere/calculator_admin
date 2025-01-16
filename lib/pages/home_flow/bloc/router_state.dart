part of 'router_bloc.dart';

class RouterState extends Equatable {
  const RouterState._({
    required this.status,
    this.user = Users.empty,
  });
  final HomeRouteStatus status;
  final Users user;

  const RouterState.initial() : this._(status: HomeRouteStatus.home);
  
  const RouterState.updateUser(Users user) : this._(status: HomeRouteStatus.update, user: user);

  @override
  List<Object> get props => [status, user];
}

enum HomeRouteStatus { home, update, updatePassword }

