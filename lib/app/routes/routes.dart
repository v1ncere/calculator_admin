import 'package:flutter/material.dart';

import 'package:calculator_admin/app/app.dart';
import 'package:calculator_admin/pages/forgot_password/views/forgot_password_page.dart';
import 'package:calculator_admin/pages/home/home.dart';
import 'package:calculator_admin/pages/login/login.dart';

List<Page<dynamic>> onGeneratePages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.forgotPassword:
      return [LoginPage.page(), ForgotPasswordPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.authenticated:
      return [HomePage.page()];
    default:
      return [LoginPage.page()];
  }
}