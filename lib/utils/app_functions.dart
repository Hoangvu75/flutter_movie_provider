import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app_mvvm/generated/assets.dart';
import 'package:movie_app_mvvm/src/normal_outlined_button.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';

import '../src/PColor.dart';
import '../src/gradient_button.dart';

class CustomDialog {
  bool isDialogShowing = false;

  void showErrorDialog(BuildContext context, SvgPicture dialogSvgPicture,
      String dialogTitle, String dialogContent, Function cancelCallback, Function confirmCallback) {
    if (!isDialogShowing) {
      isDialogShowing = true;
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          isDismissible: false,
          enableDrag: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 24 * responsiveSize.width,
                      right: 24 * responsiveSize.width,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24 * responsiveSize.width,
                      vertical: 32 * responsiveSize.width,
                    ),
                    // height: widgetSize.height * 0.5,
                    decoration: BoxDecoration(
                      color: PColors.backgroundTop,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        dialogSvgPicture,
                        SizedBox(height: 10 * responsiveSize.height),
                        Text(
                          dialogTitle,
                          style: TextStyle(
                              color: PColors.defaultText,
                              fontSize: responsiveSize.width * 18,
                              fontFamily: Assets.fontsSVNGilroySemiBold),
                        ),
                        SizedBox(height: 10 * responsiveSize.height),
                        Text(
                          dialogContent,
                          style: TextStyle(
                              color: PColors.defaultText,
                              fontSize: responsiveSize.width * 16,
                              fontFamily: Assets.fontsSVNGilroyRegular),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30 * responsiveSize.height),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            NormalOutlinedButton(
                                title: "Cancel",
                                onTap: () {
                                  isDialogShowing = false;
                                  Navigator.pop(context);
                                  cancelCallback();
                                }),
                            GradientButton(
                                title: "Confirm",
                                onTap: () {
                                  isDialogShowing = false;
                                  Navigator.pop(context);
                                  confirmCallback();
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    }
  }
}
