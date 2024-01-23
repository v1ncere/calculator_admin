import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/app/app.dart';
import 'package:calculator_admin/pages/home/home.dart';
import 'package:calculator_admin/repository/repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Page<void> page() => const MaterialPage(child: HomePage());
  static final _authRepository = FirebaseAuthRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authRepository)
      ],
      child: BlocProvider(
        create: (context) => AppBloc(firebaseAuth: _authRepository),
        child: const HomeView()
      )
    );
  }
}