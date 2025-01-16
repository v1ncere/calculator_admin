import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/pages/home_flow/home_flow.dart';

class HomeFlow extends StatelessWidget {
  const HomeFlow._();
  static Route<HomeRouteStatus> route() => MaterialPageRoute(
    builder: (context) => BlocProvider(
      create: (context) => RouterBloc(),
      child: const HomeFlow._(),
    )
  );

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<HomeRouteStatus>(
      state: context.select((RouterBloc bloc) => bloc.state.status),
      onGeneratePages: onGenerateHomePages
    );
  }
}