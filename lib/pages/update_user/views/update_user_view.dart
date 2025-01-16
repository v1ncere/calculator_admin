import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calculator_admin/pages/home_flow/home_flow.dart';
import 'package:calculator_admin/pages/update_user/update_user.dart';
import 'package:calculator_admin/pages/update_user/widgets/widgets.dart';
import 'package:calculator_admin/utils/utils.dart';

class UpdateUserView extends StatelessWidget {
  const UpdateUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "USER DETAILS",
          style: TextStyle(
            color: CustomColor.eucalyptus,
            fontSize: 16,
            fontWeight: FontWeight.w600
          )
        )
      ),
      body: BlocListener<UpdateBloc, UpdateState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(customSnackBar(
              state.message ?? "",
              FontAwesomeIcons.triangleExclamation,
              Colors.red,
              Colors.white
            ));
          }
          if (state.status.isSuccess) {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(customSnackBar(
              "Updated Successfully!",
              FontAwesomeIcons.check,
              Colors.green,
              Colors.white
            ));
            context.flow<HomeRouteStatus>().update((state) => HomeRouteStatus.home);
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              UserDetailsCard(),
              MobileDetailsCard(),
              DateDetailsCard(),
              SizedBox(height: 10.0),
              Divider(thickness: 1.0, color: Color.fromARGB(50, 37, 193, 102)),
              UpdateCard()
            ]
          )
        )
      )
    );
  }
}
