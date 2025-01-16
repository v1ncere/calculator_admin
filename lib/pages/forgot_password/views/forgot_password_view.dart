import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:calculator_admin/app/app.dart';
import 'package:calculator_admin/pages/forgot_password/forgot_password.dart';
import 'package:calculator_admin/pages/forgot_password/widgets/widgets.dart';
import 'package:calculator_admin/utils/utils.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: TextStyle(
            color: CustomColor.deepSea,
            fontSize: 16
          )
        ),
        backgroundColor: CustomColor.lime,
      ),
      backgroundColor: CustomColor.lime,
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(customSnackBar(
              state.message,
              FontAwesomeIcons.triangleExclamation,
              CustomColor.guardsmanRed,
              CustomColor.mystic
            ));
          }
          if (state.status.isSuccess) {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(customSnackBar(
              state.message,
              FontAwesomeIcons.circleCheck,
              CustomColor.deepSea,
              CustomColor.mystic
            ));
            context.flow<AppStatus>().update((state) => AppStatus.unauthenticated);
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              color: CustomColor.jewel,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EmailTextField(),
                    SizedBox(height: 15),
                    RequestButton()
                  ]
                )
              )
            )
          ),
        )
      )
    );
  }
}