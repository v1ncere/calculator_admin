import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/pages/update_user/update_user.dart';
import 'package:calculator_admin/utils/utils.dart';

class UserDetailsCard extends StatelessWidget {
  const UserDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBloc, UpdateState>(
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "email:",
                      style: TextStyle(
                        color: Colors.black45
                      )
                    ),
                    const SizedBox(width: 10),
                    Text(
                      state.user.email!, 
                      style: TextStyle(
                        color: CustomColor.eucalyptus,
                        fontWeight: FontWeight.w600
                      )
                    )
                  ]
                ),
                Row(
                  children: [
                    const Text(
                      "employee ID:",
                      style: TextStyle(
                        color: Colors.black45
                      )
                    ),
                    const SizedBox(width: 10),
                    Text(
                      state.user.employeeId!,
                      style: TextStyle(
                        color: CustomColor.blazeOrange,
                        fontWeight: FontWeight.w600
                      )  
                    )
                  ]
                )
              ]
            )
          ) 
        );
      }
    );
  }
}