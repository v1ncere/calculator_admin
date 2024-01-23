import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/app/app.dart';
import 'package:calculator_admin/repository/repository.dart';
import 'package:calculator_admin/utils/utils.dart';

class App extends StatelessWidget {
  const App({super.key});
  static Route<AppStatus> route() => MaterialPageRoute(builder: (_) => const App());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseAuthRepository(),
      child: BlocProvider(
        create: (context) => AppBloc(firebaseAuth: FirebaseAuthRepository()),
        child: const AppView(),
      )
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme(context: context).light,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGeneratePages
      )
    );
  }
}