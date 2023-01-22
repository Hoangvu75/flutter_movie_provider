import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';
import 'package:movie_app_mvvm/viewmodels/homeScreenViewModel/home_api_viewmodel.dart';
import 'package:movie_app_mvvm/views/homeScreen/components/movie_list_widget.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../src/PColor.dart';
import '../viewMoreMovieScreen/view_more_movie_screen.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  void initState() {
    Provider.of<HomeApiViewModel>(context, listen: false).fetchTrendingMovies();
    Provider.of<HomeApiViewModel>(context, listen: false).fetchTrendingTvs();
    Provider.of<HomeApiViewModel>(context, listen: false).fetchUpcomingMovies();
    Provider.of<HomeApiViewModel>(context, listen: false).fetchPopularMovies();
    Provider.of<HomeApiViewModel>(context, listen: false).fetchTopRatedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final havm = Provider.of<HomeApiViewModel>(context);

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          PColors.backgroundTop,
          PColors.backgroundBottom,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 500 * responsiveSize.height,
            flexibleSpace: FlexibleSpaceBar(
              background: havm.loadingTrendingTv
                  ? Container()
                  : Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500${havm.trendingTvList[0].posterPath}"),
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
                          bottom: 75 * responsiveSize.width,
                          left: 10 * responsiveSize.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Top trending Tv",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: Assets.fontsSVNGilroyRegular,
                                  fontSize: 20 * responsiveSize.width,
                                ),
                              ),
                              Text(
                                havm.trendingTvList[0].name.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: Assets.fontsSVNGilroyBold,
                                  fontSize: 25 * responsiveSize.width,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 10 * responsiveSize.width,
                          right: 10 * responsiveSize.width,
                          child: Row(
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
                                onPressed: () {
                                  //play button press action
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        8 * responsiveSize.width),
                                    child: const Icon(
                                      Icons.play_arrow,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
            backgroundColor: Colors.black,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50 * responsiveSize.height,
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedOpacity(
              opacity: havm.loadingTrendingMovie ? 0 : 1,
              duration: const Duration(milliseconds: 1000),
              child: MovieListWidget(
                  movies: havm.trendingMovieList,
                  title: "Trending Movies",
                  viewMoreInScreen:
                      const ViewMoreMovieScreen(type: "trending-movies")),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedOpacity(
              opacity: havm.loadingTrendingTv ? 0 : 1,
              duration: const Duration(milliseconds: 1000),
              child: MovieListWidget(
                  movies: havm.trendingTvList,
                  title: "Trending Tvs",
                  viewMoreInScreen:
                      const ViewMoreMovieScreen(type: "trending-tvs")),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedOpacity(
              opacity: havm.loadingTrendingTv ? 0 : 1,
              duration: const Duration(milliseconds: 1000),
              child: MovieListWidget(
                  movies: havm.upcomingList,
                  title: "Upcoming",
                  viewMoreInScreen:
                      const ViewMoreMovieScreen(type: "upcoming")),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedOpacity(
              opacity: havm.loadingPopular ? 0 : 1,
              duration: const Duration(milliseconds: 1000),
              child: MovieListWidget(
                  movies: havm.popularList,
                  title: "Popular",
                  viewMoreInScreen: const ViewMoreMovieScreen(type: "popular")),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedOpacity(
              opacity: havm.loadingTopRated ? 0 : 1,
              duration: const Duration(milliseconds: 1000),
              child: MovieListWidget(
                  movies: havm.topRatedList,
                  title: "Top Rated",
                  viewMoreInScreen: const ViewMoreMovieScreen(type: "top-rated")),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100 * responsiveSize.width,
            ),
          )
        ],
      ),
    );
  }
}
