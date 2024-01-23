import 'package:calculator_admin/pages/home/widgets/widgets.dart';
import 'package:flutter/material.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeState();
}

class HomeState extends State<HomeView> with WidgetsBindingObserver {


  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        drawer: SideDrawer(),
        body: Center(child: Text("HOME"))
      )
    );
  }
}