import 'package:flutter/material.dart';

Widget backgroundImage(left, top, right, bottom, height, width, turns) {
  return Positioned(top: top, right: right, bottom: bottom, left: left,
    child: RotationTransition(
      turns: AlwaysStoppedAnimation(turns),
      child: SizedBox(height: height, width: width,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/splash.png"),
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.06), BlendMode.dstATop),
              fit: BoxFit.scaleDown,
            )
          )
        )
      )
    )
  );
}

