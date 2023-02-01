import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:movie_app_mvvm/src/PColor.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';

import '../../../apiResponse/movie_response.dart';
import '../../../generated/assets.dart';
import '../../movieDetailsScreen/movie_details_screen.dart';

class MoviePageView extends StatefulWidget {
  final Movie movie;

  const MoviePageView({super.key, required this.movie});

  @override
  State<MoviePageView> createState() => _MoviePageViewState();
}

class _MoviePageViewState extends State<MoviePageView> {
  int lineOfOverview = 3;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Colors.black),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20 * responsiveSize.width),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ))),
        Positioned(
          bottom: 50 * responsiveSize.width,
          left: 10 * responsiveSize.width,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 20 * responsiveSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                    TextSpan(
                      text: widget.movie.title.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: Assets.fontsSVNGilroyBold,
                        fontSize: 30 * responsiveSize.width,
                      ),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                SizedBox(
                  height: 10 * responsiveSize.width,
                ),
                ScaleTap(
                  onPressed: () {
                    setState(() {
                      lineOfOverview = 20;
                    });
                  },
                  child: Text.rich(
                      TextSpan(
                        text: widget.movie.overview.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: Assets.fontsSVNGilroyRegular,
                          fontSize: 20 * responsiveSize.width,
                        ),
                      ),
                      maxLines: lineOfOverview,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(
                  height: 20 * responsiveSize.width,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Watch now!",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: Assets.fontsSVNGilroySemiBold,
                          fontSize: 20 * responsiveSize.width,
                        ),
                      ),
                      SizedBox(
                        width: 10 * responsiveSize.width,
                      ),
                      ScaleTap(
                        onPressed: () {},
                        child: OpenContainer(
                          openColor: Colors.white,
                          transitionDuration: const Duration(milliseconds: 750),
                          transitionType: ContainerTransitionType.fadeThrough,
                          closedBuilder: (BuildContext context, void Function() action) => Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8 * responsiveSize.width),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          openBuilder: (BuildContext context, void Function({Object? returnValue}) action) =>
                              MovieDetailsScreen(id: widget.movie.id!),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
