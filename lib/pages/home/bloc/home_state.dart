part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.usersList = const <Users>[],
    this.searchQuery = const Search.pure(),
    this.status = Status.initial,
    this.message = ""
  });
  final List<Users> usersList;
  final Search searchQuery;
  final Status status;
  final String message;

  HomeState copyWith({
    List<Users>? usersList,
    Search? searchQuery,
    Status? status,
    String? message
  }) {
    return HomeState(
      usersList: usersList ?? this.usersList,
      searchQuery: searchQuery ?? this.searchQuery,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }

  @override
  List<Object> get props => [usersList, searchQuery, status, message];
}
