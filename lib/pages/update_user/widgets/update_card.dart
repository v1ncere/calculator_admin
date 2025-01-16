import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculator_admin/pages/update_user/update_user.dart';
import 'package:calculator_admin/utils/utils.dart';

class UpdateCard extends StatelessWidget {
  const UpdateCard({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBloc, UpdateState>(
      builder: (context, state) {
        final now = DateTime.now();
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "UPDATE EXPIRY",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: CustomColor.eucalyptus,
                      )
                    )
                  ]
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(CustomColor.blazeOrange),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                            )
                          ),
                          label: Text(
                            now.isAtSameMomentAs(state.date ?? now)
                            ? "select date" 
                            : getDateString(state.date ?? now)
                          ),
                          icon: const Icon(Icons.calendar_month_outlined),
                          onPressed: () async {
                            await showDatePicker(
                              context: context,
                              initialDate: state.date,
                              firstDate: DateTime(2023, 04, 11),
                              lastDate: DateTime(2101, 04, 11)
                            ).then((value) {
                              context.read<UpdateBloc>().add(DatePickerChanged(value ?? now));
                            });
                          }
                        )
                      ]
                    ),
                    const UpdateButton()
                  ]
                )
              ]
            )
          )
        );
      }
    );
  }
}

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBloc, UpdateState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
            )
          ),
          onPressed: () => context.read<UpdateBloc>().add(UserUpdated()),
          child: state.status.isLoading
          ? Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Center(
                child: SizedBox.fromSize(
                  size: const Size(30, 30),
                  child: CircularProgressIndicator(
                    color: CustomColor.mystic,
                  ),
                )
              ),
            )
          : const Text(
              'UPDATE',
              style: TextStyle(fontWeight: FontWeight.w900)
            )
        );
      }
    );
  }
}