import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:calculator_admin/pages/login/login.dart';
import 'package:calculator_admin/pages/login/widgets/widgets.dart';
import 'package:calculator_admin/utils/utils.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.lime,
      body: BlocListener<LoginBloc, LoginState>(
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
        },
        child: Stack(
          children: [
            /// TOP BG IMAGE
            backgroundImage(null, 50.0, null, null, 300.0, 300.0, 15.0 / 360.0),
            /// BOTTOM BG IMAGE
            backgroundImage(null, null, 20.0, 40.0, 150.0, 150.0, 15.0 / 360.0),
            // BACKGROUND LAYOUT
            LayoutBuilder(
              builder:(BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:BoxConstraints(minHeight: viewportConstraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            color: CustomColor.jewel,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: SizedBox(
                              height: 350,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Calculator", style: TextStyle(
                                          color: CustomColor.mystic,
                                          fontFamily: 'San-Serif',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30
                                        )),
                                        Text("Admin", style: TextStyle(
                                          color: CustomColor.lime,
                                          fontFamily: 'San-Serif',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30
                                        ))
                                      ]
                                    ),
                                    const EmailTextField(),           
                                    const PasswordTextField(),
                                    const SizedBox(height: 5),                              
                                    const LoginButton(),
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        ForgotPasswordButton()
                                        // SignUpButton()
                                      ]
                                    )
                                  ]
                                )
                              )
                            )
                          )
                        )
                      ]
                    )
                  )
                );
              }
            )
          ]
        )
      )
    );
  }
}