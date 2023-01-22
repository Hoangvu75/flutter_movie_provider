import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:movie_app_mvvm/apiResponse/movie_credits_response.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../generated/assets.dart';
import '../../../src/PColor.dart';

class CastItem extends StatelessWidget {
  final Cast cast;

  const CastItem({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 15 * responsiveSize.width,
            horizontal: 15 * responsiveSize.height),
        child: Container(
          width: 160 * responsiveSize.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5 * responsiveSize.width,
                blurRadius: 7 * responsiveSize.width,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: AspectRatio(
            aspectRatio: 1 / 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: cast.profilePath != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w500${cast.profilePath}',
                            fit: BoxFit.cover,
                            height: 200,
                            width: 150,
                          )
                        : Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 200,
                              width: 150,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  SizedBox(height: 10 * responsiveSize.height),
                  Text.rich(
                      TextSpan(
                        text: cast.name.toString(),
                        style: TextStyle(
                            fontSize: 15 * responsiveSize.width,
                            color: PColors.defaultText,
                            fontFamily: Assets.fontsSVNGilroySemiBold),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: 10 * responsiveSize.height),
                  Text.rich(
                      TextSpan(
                        text: cast.character.toString(),
                        style: TextStyle(
                            fontSize: 13 * responsiveSize.width,
                            color: PColors.defaultText,
                            fontFamily: Assets.fontsSVNGilroyRegular),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
