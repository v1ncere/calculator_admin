import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/pages/home_flow/home_flow.dart';
import 'package:calculator_admin/pages/update_user/update_user.dart';
import 'package:calculator_admin/repository/repository.dart';

class UpdateUserPage extends StatelessWidget {
  const UpdateUserPage({super.key});
  static Page<void> page() => const MaterialPage(child: UpdateUserPage());
  static final _databaseRepository = FirebaseDatabaseRepository();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RouterBloc, RouterState, Users>(
      selector: (state) => state.user,
      builder: (context, state) {
        return RepositoryProvider(
          create: (context) => _databaseRepository,
          child: BlocProvider(
            create: (context) => UpdateBloc(firebaseDatabase: _databaseRepository)
            ..add(UserLoaded(state)),
            child: const UpdateUserView()
          )
        );
      }
    );
  }
}
