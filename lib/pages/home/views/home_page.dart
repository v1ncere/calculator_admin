import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/pages/home/home.dart';
import 'package:calculator_admin/repository/repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Page<void> page() => const MaterialPage(child: HomePage());
  static final _firebaseRepository = FirebaseDatabaseRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(create: (context) => _firebaseRepository,
      child: BlocProvider(
        create: (context) => HomeBloc(firebaseDatabase: _firebaseRepository)
        ..add(const UsersLoaded()),
        child: const HomeView()
      )
    );
  }
}