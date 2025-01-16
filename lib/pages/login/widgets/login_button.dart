import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:calculator_admin/pages/login/login.dart';
import 'package:calculator_admin/utils/utils.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              )
            )
          )
        : SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: CustomColor.deepSea,
              backgroundColor: CustomColor.turbo,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20
              )
            ),
            onPressed: state.isValid
            ? () => context.read<LoginBloc>().add(LoggedInWithCredentials())
            : null,
            child: const Text('LOGIN'),
          )
        );
      }
    );
  }
}