import 'package:flutter/material.dart';

import 'package:calculator_admin/pages/home/home.dart';
import 'package:calculator_admin/pages/home_flow/home_flow.dart';
import 'package:calculator_admin/pages/update_password/update_password.dart';
import 'package:calculator_admin/pages/update_user/update_user.dart';

List<Page<dynamic>> onGenerateHomePages(HomeRouteStatus state, List<Page<dynamic>> pages) {
  switch(state) {
    case HomeRouteStatus.home:
      return [HomePage.page()];
    case HomeRouteStatus.update:
      return [HomePage.page(), UpdateUserPage.page()];
    case HomeRouteStatus.updatePassword:
      return [HomePage.page(), UpdatePasswordPage.page()];
  }
}