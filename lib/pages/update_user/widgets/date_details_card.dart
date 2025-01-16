import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/pages/update_user/update_user.dart';
import 'package:calculator_admin/utils/utils.dart';

class DateDetailsCard extends StatelessWidget {
  const DateDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBloc, UpdateState>(
      builder: (context, state) {
        final now = DateTime.now();
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "created:",
                      style: TextStyle(
                        color: Colors.black45
                      )
                    ),
                    const SizedBox(width: 10),
                    Text(
                      getDateString(state.user.createdAt ?? now),
                      style: TextStyle(
                        color: CustomColor.eucalyptus,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ]
                ),
                Row(
                  children: [
                    const Text(
                      "last update:",
                      style: TextStyle(
                        color: Colors.black45
                      )
                    ),
                    const SizedBox(width: 10),
                    Text(
                      getDateString(state.user.updatedAt ?? now),
                      style: TextStyle(
                        color: CustomColor.eucalyptus,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ]
                ),
                Row(
                  children: [
                    const Text(
                      "login expiry:",
                      style: TextStyle(
                        color: Colors.black45
                      )
                    ),
                    const SizedBox(width: 10),
                    Text(
                      getDateString(state.user.expiry ?? now),
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
      },
    );
  }
}