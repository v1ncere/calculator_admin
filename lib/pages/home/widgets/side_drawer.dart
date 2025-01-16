import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calculator_admin/app/app.dart';
import 'package:calculator_admin/pages/home_flow/home_flow.dart';
import 'package:calculator_admin/utils/utils.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text('${FirebaseAuth.instance.currentUser!.email}'),
            accountName: const Text(
              'ADMIN',
              style: TextStyle(
                fontWeight: FontWeight.w600
              )
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: CustomColor.deepSea,
              child: const ClipOval(
                child: Icon(
                  FontAwesomeIcons.faceSmile,
                  color: Colors.white,
                  size: 50
                )
              )
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/profile-bg.png')
              )
            )
          ),
          ListTile(
            title: const Text('update password'),
            leading: Icon(
              FontAwesomeIcons.unlock,
              color: CustomColor.eucalyptus,
            ),
            onTap: () {
              context.flow<HomeRouteStatus>().update((state) => HomeRouteStatus.updatePassword);
            }
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.black12,
          ),
          ListTile(
            title: const Text('logout'),
            leading: Icon(
              FontAwesomeIcons.arrowRightToBracket,
              color: CustomColor.blazeOrange,
            ),
            onTap: () {
              context.flow<HomeRouteStatus>().complete();
              context.read<AppBloc>().add(AppLogoutRequested());
            }
          )
        ]
      )
    );
  }
}