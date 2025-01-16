import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/pages/home/home.dart';
import 'package:calculator_admin/pages/home/widgets/widgets.dart';
import 'package:calculator_admin/utils/utils.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ADMIN PANEL",
          style: TextStyle(
            color: CustomColor.eucalyptus,
            fontSize: 16,
            fontWeight: FontWeight.w600
          )
        )
      ),
      drawer: const SideDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(const UsersLoaded());
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SearchBox(),
                SizedBox(height: 10),
                UsersListDisplay()
              ]
            )
          )
        )
      )
    );
  }
}