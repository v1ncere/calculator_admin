import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/pages/home/home.dart';
import 'package:calculator_admin/pages/home/widgets/widgets.dart';
import 'package:calculator_admin/utils/utils.dart';

class UsersListDisplay extends StatelessWidget {
  const UsersListDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (state.status.isSuccess) {
          return ListView.separated(
            itemCount: state.usersList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final user = state.usersList[index];
              return UserDisplayCard(user: user);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(thickness: 1.0, color: Color.fromARGB(50, 37, 193, 102));
            }
          );
        }
        if (state.status.isFailure) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w700
              )
            )
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}
