import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app_mvvm/src/PColor.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';

import '../../../generated/assets.dart';

class MySidebar extends StatelessWidget {
  const MySidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 7 / 10,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Container(
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(51, 51, 51, 1.0)),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30 * responsiveSize.height,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10 * responsiveSize.height,
                        ),
                        SvgPicture.asset(
                          Assets.svgsAvatarDefault,
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          width: 10 * responsiveSize.height,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 7 / 10 -
                              70 * responsiveSize.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vu Huy Hoang",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: Assets.fontsSVNGilroyRegular,
                                  fontSize: 18 * responsiveSize.width,
                                ),
                              ),
                              SizedBox(
                                height: 2.5 * responsiveSize.height,
                              ),
                              Text.rich(
                                  TextSpan(
                                    text: "uchihavuhuyhoang@gmail.com",
                                    style: TextStyle(
                                        fontSize: 15 * responsiveSize.width,
                                        color: Colors.white,
                                        fontFamily:
                                            Assets.fontsSVNGilroyRegular,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30 * responsiveSize.height,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20 * responsiveSize.height,
              ),
              ScaleTap(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.svgsIcGameCode, width: 30, height: 30),
                    SizedBox(
                      width: 10 * responsiveSize.width,
                    ),
                    Text(
                      "New update",
                      style: TextStyle(
                        color: PColors.defaultText,
                        fontFamily: Assets.fontsSVNGilroyMedium,
                        fontSize: 18 * responsiveSize.width,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10 * responsiveSize.height,
              ),
              Divider(thickness: 0.5 * responsiveSize.width),

              SizedBox(
                height: 10 * responsiveSize.height,
              ),
              ScaleTap(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.svgsIcQa, width: 30, height: 30),
                    SizedBox(
                      width: 10 * responsiveSize.width,
                    ),
                    Text(
                      "App info",
                      style: TextStyle(
                        color: PColors.defaultText,
                        fontFamily: Assets.fontsSVNGilroyMedium,
                        fontSize: 18 * responsiveSize.width,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10 * responsiveSize.height,
              ),
              Divider(thickness: 0.5 * responsiveSize.width),

              SizedBox(
                height: 10 * responsiveSize.height,
              ),
              ScaleTap(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.svgsIcProfileSpeakerMessages, width: 30, height: 30),
                    SizedBox(
                      width: 10 * responsiveSize.width,
                    ),
                    Text(
                      "Contact",
                      style: TextStyle(
                        color: PColors.defaultText,
                        fontFamily: Assets.fontsSVNGilroyMedium,
                        fontSize: 18 * responsiveSize.width,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10 * responsiveSize.height,
              ),
              Divider(thickness: 0.5 * responsiveSize.width),

              SizedBox(
                height: 10 * responsiveSize.height,
              ),
              ScaleTap(
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.svgsIcAgendaLogout, width: 30, height: 30),
                    SizedBox(
                      width: 10 * responsiveSize.width,
                    ),
                    Text(
                      "Quit",
                      style: TextStyle(
                        color: PColors.defaultText,
                        fontFamily: Assets.fontsSVNGilroyMedium,
                        fontSize: 18 * responsiveSize.width,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10 * responsiveSize.height,
              ),
            ],
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 3 / 10,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
