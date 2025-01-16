import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/repository/repository.dart';
import 'package:calculator_admin/utils/utils.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required FirebaseDatabaseRepository firebaseDatabase,
  }) : _databaseRepository = firebaseDatabase,
  super(const HomeState()) {
    on<UsersLoaded>(_onUsersLoaded);
    on<SearchTextFieldChanged>(_onSearchTextFieldChanged);
  }
  final FirebaseDatabaseRepository _databaseRepository;

  void _onSearchTextFieldChanged(SearchTextFieldChanged event, Emitter<HomeState> emit) {
    final search = Search.dirty(event.search);
    emit(state.copyWith(searchQuery: search));
  }

  void _onUsersLoaded(UsersLoaded event, Emitter<HomeState> emit) async {
    await emit.forEach(
      _databaseRepository.getUsersListStream(),
      onData: (data) {
        List<Users> filteredUsers = data;
        final query = event.searchQuery.trim();
        final filter = event.filter.trim();

        if (event.filter.isNotEmpty) {
          if (filter == "newest") {
            filteredUsers.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
          } else if (filter == "oldest") {
            filteredUsers.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
          } else if (filter == "newlyUpdated") {
            filteredUsers.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
          } else if (filter == "oldestUpdated") {
            filteredUsers.sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
          }
        }

        if (event.searchQuery.isNotEmpty) {
          filteredUsers = filteredUsers.where((element) {
            return element.employeeId!.contains(query);
          }).toList();
        }

        if (filteredUsers.isNotEmpty) {
          return state.copyWith(status: Status.success, usersList: filteredUsers);
        } else {
          return state.copyWith(status: Status.failure, message: 'empty');
        }
      }
    );
  }
}
