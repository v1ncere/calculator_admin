import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calculator_admin/pages/home_flow/home_flow.dart';
import 'package:calculator_admin/repository/repository.dart';
import 'package:calculator_admin/utils/utils.dart';

class UserDisplayCard extends StatelessWidget {
  const UserDisplayCard({
    super.key,
    required this.user
  });
  final Users user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<RouterBloc>().add(RouterUsersModelPassed(user));
        context.flow<HomeRouteStatus>().update((state) => HomeRouteStatus.update);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Text(user.employeeId!,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: CustomColor.deepSea
                  )
                )
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.email!,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: CustomColor.jewel
                      )
                    ),
                    Text("${user.mobileNumber!}",
                      style: TextStyle(
                        color: CustomColor.deepSea
                      )
                    ),
                    const SizedBox(height: 5),
                    Text("expire: ${getExpiryDateString(user.expiry!)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: CustomColor.guardsmanRed
                      )
                    )
                  ]
                )
              ),
              Icon(
                FontAwesomeIcons.caretRight,
                color: CustomColor.deepSea,
                size: 14,
              )
            ]
          )
        )
      )
    );
  }
}
