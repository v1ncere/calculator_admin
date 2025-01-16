import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:calculator_admin/pages/home_flow/home_flow.dart';
import 'package:calculator_admin/pages/update_password/update_password.dart';
import 'package:calculator_admin/pages/update_password/widgets/widgets.dart';
import 'package:calculator_admin/utils/utils.dart';

class UpdatePasswordView extends StatelessWidget {
  const UpdatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Password"),
      ),
      body: BlocListener<UpdatePasswordBloc, UpdatePasswordState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(customSnackBar(
              state.message ?? "",
              FontAwesomeIcons.triangleExclamation,
              CustomColor.guardsmanRed,
              CustomColor.mystic
            ));
          }
          if (state.status.isSuccess) {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(customSnackBar(
              "Password Update Successful!",
              FontAwesomeIcons.circleCheck,
              CustomColor.eucalyptus,
              CustomColor.mystic
            ));
            context.flow<HomeRouteStatus>().update((state) => HomeRouteStatus.home);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            color: CustomColor.jewel,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PasswordTextField(),
                  SizedBox(height: 10),         
                  NewPasswordTextField(),
                  SizedBox(height: 10),  
                  ConfirmNewPasswordTextField(),
                  SizedBox(height: 15),                              
                  UpdatePasswordButton(),
                ]
              )
            )
          ),
        )
      )
    );
  }
}