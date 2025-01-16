import 'dart:async';

import 'package:flutter/material.dart';

import 'package:calculator_admin/pages/home_flow/home_flow.dart';

class HomeLanding extends StatefulWidget {
  const HomeLanding({super.key});
  static Page<void> page() => const MaterialPage(child: HomeLanding());

  @override
  State<HomeLanding>  createState() => HomeLandingState();
}

class HomeLandingState extends State<HomeLanding> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage("assets/fcb-calculator.png"),
          height: 100,
          width: 100,
        )
      )
    );
  }

  Future<Timer> startTime() async {
    return Timer(const Duration(milliseconds: 1000), () async {
      await Navigator.of(context).push(HomeFlow.route());
      if (!mounted) return;
    });
  }
}
