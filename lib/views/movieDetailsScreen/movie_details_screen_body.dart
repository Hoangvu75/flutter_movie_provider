import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';
import 'package:movie_app_mvvm/viewmodels/movieDetailScreenViewModel/movie_credits_api_viewmodel.dart';
import 'package:movie_app_mvvm/views/movieDetailsScreen/components/cast_item_widget.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../src/PColor.dart';
import '../../src/gradient_button.dart';
import '../../viewmodels/movieDetailScreenViewModel/movie_details_api_viewmodel.dart';
import '../../viewmodels/scroll_controller_viewmodel.dart';

class MovieDetailsScreenBody extends StatefulWidget {
  const MovieDetailsScreenBody({super.key});

  @override
  State<MovieDetailsScreenBody> createState() => _MovieDetailsScreenBodyState();
}

class _MovieDetailsScreenBodyState extends State<MovieDetailsScreenBody> {
  late MovieDetailsApiViewModel mdavm;
  late MovieCreditsApiViewModel mcavm;
  late ScrollControllerViewModel scvm;

  @override
  void initState() {
    mdavm = Provider.of<MovieDetailsApiViewModel>(context, listen: false);
    mcavm = Provider.of<MovieCreditsApiViewModel>(context, listen: false);
    scvm = Provider.of<ScrollControllerViewModel>(context, listen: false);

    mdavm.fetchMovieDetails();
    mcavm.fetchMovieCredits();
    scvm.createScrollControlListener();
    super.initState();
  }

  @override
  void dispose() {
    scvm.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mdavm = Provider.of<MovieDetailsApiViewModel>(context, listen: true);
    mcavm = Provider.of<MovieCreditsApiViewModel>(context, listen: true);
    scvm = Provider.of<ScrollControllerViewModel>(context, listen: true);

    return RefreshIndicator(
      color: PColors.darkBlue,
      onRefresh: () async {
        await mdavm.fetchMovieDetails();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              PColors.backgroundTop,
              PColors.backgroundBottom,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AnimatedOpacity(
          opacity: mdavm.loading ? 0 : 1,
          duration: const Duration(milliseconds: 1000),
          child: CustomScrollView(
            controller: scvm.bodyScrollController,
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                leading: ScaleTap(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(Assets.svgsIcBackCircle)),
                leadingWidth: 70,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 250 * responsiveSize.width,
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(scvm.isTitleOnTop ? "Movie details" : "",
                      style: TextStyle(
                          color: PColors.darkBlue,
                          fontFamily: Assets.fontsSVNGilroyBold,
                          fontSize: 16 * responsiveSize.width)),
                  centerTitle: true,
                  background: mdavm.loading
                      ? Container()
                      : Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w500${mdavm.movieDetail.posterPath}"),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              child: Opacity(
                                opacity: 0.3,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 15 * responsiveSize.width,
                              left: 10 * responsiveSize.width,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Movie details",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: Assets.fontsSVNGilroyRegular,
                                        fontSize: 20 * responsiveSize.width,
                                      ),
                                    ),
                                    Text.rich(
                                        TextSpan(
                                          text: mdavm.movieDetail.title.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: Assets.fontsSVNGilroyBold,
                                            fontSize: 25 * responsiveSize.width,
                                          ),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 25 * responsiveSize.height,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 10 * responsiveSize.width),
                  child: Text(
                    "Overview",
                    style: TextStyle(
                        color: PColors.defaultText,
                        fontFamily: Assets.fontsSVNGilroySemiBold,
                        fontSize: 24 * responsiveSize.width),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 10 * responsiveSize.height),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10 * responsiveSize.width),
                  child: Text(
                    mdavm.loading ? "" : mdavm.movieDetail.overview.toString(),
                    style: TextStyle(
                        color: PColors.defaultText,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                        fontSize: 16 * responsiveSize.width),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 25 * responsiveSize.height,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 10 * responsiveSize.width),
                  child: Text(
                    "Top billed cast",
                    style: TextStyle(
                        color: PColors.defaultText,
                        fontFamily: Assets.fontsSVNGilroySemiBold,
                        fontSize: 24 * responsiveSize.width),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10 * responsiveSize.height,
                ),
              ),
              SliverToBoxAdapter(
                child: mcavm.loading
                    ? Container()
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: (mcavm.movieCredits.cast!.length >= 9)
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < 9; i++) CastItem(cast: mcavm.movieCredits.cast![i]),
                                ],
                              )
                            : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                for (int i = 0; i < mcavm.movieCredits.cast!.length; i++)
                                  CastItem(cast: mcavm.movieCredits.cast![i]),
                              ]),
                      ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 50 * responsiveSize.height,
                ),
              ),
              SliverToBoxAdapter(
                  child: Container(
                      padding:
                          EdgeInsets.fromLTRB(15 * responsiveSize.width, 0, 15 * responsiveSize.width, 0),
                      child: GradientButton(
                          title: "Save",
                          onTap: () async {
                            // String filePath = Assets.movieSavedDB;
                            // String contents = await rootBundle.loadString(filePath);
                            // Map<String, dynamic> jsonMap = json.decode(contents);
                            // List<dynamic> movieList = jsonMap['movie_list'];
                            // movieList.add(mdavm.movieId);
                            // jsonMap['movie_list'] = movieList;
                            // String updatedContents = json.encode(jsonMap);
                            // await File(filePath).writeAsString(updatedContents);
                          }))),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 100 * responsiveSize.height,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
