import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/pages/update_user/update_user.dart';

class MobileDetailsCard extends StatelessWidget {
  const MobileDetailsCard({super.key});

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
                      "mobile no:",
                      style: TextStyle(
                        color: Colors.black45,
                      )
                    ),
                    const SizedBox(width: 10),
                    Text("${state.user.mobileNumber ?? 0}")
                  ]
                ),
                Row(
                  children: [
                    const Text(
                      "mobile phone ID:",
                      style: TextStyle(
                        color: Colors.black45,
                      )
                    ),
                    const SizedBox(width: 10),
                    Text(state.user.phoneId!)
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