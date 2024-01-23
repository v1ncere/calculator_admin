import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/pages/forgot_password/forgot_password.dart';
import 'package:calculator_admin/repository/repository.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});
  
  static Page<void> page() => const MaterialPage<void>(child: ForgotPasswordPage());
  static final FirebaseAuthRepository _authRepository = FirebaseAuthRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _authRepository,
      child: BlocProvider(
        create: (context) => ForgotPasswordBloc(authRepository: _authRepository),
        child: const ForgotPasswordView(),
      )
    );
  }
}