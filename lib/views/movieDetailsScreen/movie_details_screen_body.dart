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
import '../../viewmodels/movieDetailScreenViewModel/movie_details_api_viewmodel.dart';
import '../../viewmodels/scroll_controller_viewmodel.dart';

class MovieDetailsScreenBody extends StatefulWidget {
  const MovieDetailsScreenBody({super.key});

  @override
  State<MovieDetailsScreenBody> createState() => _MovieDetailsScreenBodyState();
}

class _MovieDetailsScreenBodyState extends State<MovieDetailsScreenBody> {
  @override
  void initState() {
    Provider.of<MovieDetailsApiViewModel>(context, listen: false)
        .fetchMovieDetails();
    Provider.of<MovieCreditsApiViewModel>(context, listen: false)
        .fetchMovieCredits();
    Provider.of<ScrollControllerViewModel>(context, listen: false)
        .createScrollControlListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mdavm = Provider.of<MovieDetailsApiViewModel>(context);
    final mcavm = Provider.of<MovieCreditsApiViewModel>(context);
    final scvm = Provider.of<ScrollControllerViewModel>(context);

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
                                        fontFamily:
                                            Assets.fontsSVNGilroyRegular,
                                        fontSize: 20 * responsiveSize.width,
                                      ),
                                    ),
                                    Text.rich(
                                        TextSpan(
                                          text: mdavm.movieDetail.title
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily:
                                                Assets.fontsSVNGilroyBold,
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
                  padding: EdgeInsets.symmetric(
                      horizontal: 10 * responsiveSize.width),
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
                                  for (int i = 0; i < 9; i++)
                                    CastItem(cast: mcavm.movieCredits.cast![i]),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    for (int i = 0;
                                        i < mcavm.movieCredits.cast!.length;
                                        i++)
                                      CastItem(
                                          cast: mcavm.movieCredits.cast![i]),
                                  ]),
                      ),
              ),
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
