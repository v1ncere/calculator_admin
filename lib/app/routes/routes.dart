import 'package:flutter/material.dart';

import 'package:calculator_admin/app/app.dart';
import 'package:calculator_admin/pages/forgot_password/forgot_password.dart';
import 'package:calculator_admin/pages/home_flow/home_flow.dart';
import 'package:calculator_admin/pages/login/login.dart';

List<Page<dynamic>> onGeneratePages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.forgotPassword:
      return [LoginPage.page(), ForgotPasswordPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.authenticated:
      return [HomeLanding.page()];
  }
}