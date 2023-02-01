import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

import '../generated/assets.dart';
import 'PColor.dart';

class NormalOutlinedButton extends StatelessWidget {
  final String title;
  final Function() onTap;

  const NormalOutlinedButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: PColors.blueMain),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Center(
              child: Text(
            title,
            style: TextStyle(
              color: PColors.blueMain,
              fontFamily: Assets.fontsSVNGilroySemiBold,
              fontSize: 16,
            ),
          )),
        ),
      ),
    );
  }
}
