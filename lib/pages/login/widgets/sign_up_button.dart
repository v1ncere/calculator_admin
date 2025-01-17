import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // context.flow<AppStatus>().update((state) => AppStatus.signup)
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.blue.withOpacity(0.04);
          }
          if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
            return Colors.blue.withOpacity(0.12);
          }
          return null;
        })
      ),
      child: const Text(
        "Sign Up",
        style: TextStyle(
          color: Colors.white
        )
      )
    );
  }
}