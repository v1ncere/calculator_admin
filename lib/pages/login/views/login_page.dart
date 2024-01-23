import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/pages/login/login.dart';
import 'package:calculator_admin/repository/repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: LoginPage());
  static final _authRepository = FirebaseAuthRepository();
  static final _databaseRepository = FirebaseDatabaseRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authRepository),
        RepositoryProvider(create: (context) => _databaseRepository)
      ],
      child: BlocProvider(
        create: (context) => LoginBloc(authRepository: _authRepository, databaseRepository: _databaseRepository),
        child: const LoginView(),
      )
    );
  }
}