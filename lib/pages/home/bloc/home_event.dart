part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class UsersLoaded extends HomeEvent {
  const UsersLoaded({
    this.searchQuery = "",
    this.filter = "",
  });
  final String searchQuery;
  final String filter;

  @override
  List<Object> get props => [searchQuery, filter];
}

final class SearchTextFieldChanged extends HomeEvent {
  const SearchTextFieldChanged(this.search);
  final String search;

  @override
  List<Object> get props => [search];
}