import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';

import '../generated/assets.dart';
import 'PColor.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final String assetsIcon;
  final bool isLeft;
  final List<Color>? colors;

  const GradientButton({
    super.key,
    required this.title,
    this.onTap,
    this.assetsIcon = "",
    this.isLeft = true,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      enableFeedback: false,
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: colors ??
                [
                  PColors.gradientButtonStart,
                  PColors.gradientButtonEnd,
                ],
          ),
          border: Border.all(color: PColors.blueMain),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: _checkVisibleLeft(),
                child: SvgPicture.asset(
                  assetsIcon,
                  width: 25,
                  height: 25,
                  color: Colors.white,
                ),
              ),
              Visibility(
                visible: _checkVisibleLeft(),
                child: const SizedBox(
                  width: 10,
                ),
              ),
              Text(
                title,
                style:
                    const TextStyle(color: Colors.white, fontSize: 16, fontFamily: Assets.fontsSVNGilroyRegular),
              ),
              Visibility(
                visible: _checkVisibleRight(),
                child: const SizedBox(
                  width: 10,
                ),
              ),
              Visibility(
                visible: _checkVisibleRight(),
                child: SvgPicture.asset(
                  assetsIcon,
                  width: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _checkVisibleLeft() {
    if (assetsIcon.isEmpty) {
      return false;
    } else {
      if (isLeft == true) return true;
    }
    return false;
  }

  bool _checkVisibleRight() {
    if (assetsIcon.isEmpty) {
      return false;
    } else {
      if (isLeft == false) return true;
    }
    return false;
  }
}
