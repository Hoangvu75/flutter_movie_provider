import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';
import 'package:movie_app_mvvm/viewmodels/homeScreenViewModel/home_api_viewmodel.dart';
import 'package:movie_app_mvvm/views/homeScreen/components/movie_list_widget.dart';
import 'package:movie_app_mvvm/views/homeScreen/components/sidebar.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../src/PColor.dart';
import '../movieDetailsScreen/movie_details_screen.dart';
import '../viewMoreMovieScreen/view_more_movie_screen.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody>
    with TickerProviderStateMixin {
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
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0.75),
            leading: ScaleTap(
                onPressed: () {
                  showSideBar();
                },
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30 * responsiveSize.width,
                )),
            leadingWidth: 70,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            pinned: true,
            snap: false,
            floating: false,
            elevation: 0,
            automaticallyImplyLeading: false,
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
                                    "https://image.tmdb.org/t/p/w500${havm.trendingMovieList[0].posterPath}"),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            child: Container(
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )))
                            ),
                        Positioned(
                          bottom: 75 * responsiveSize.width,
                          left: 10 * responsiveSize.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Top trending movie",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: Assets.fontsSVNGilroyRegular,
                                  fontSize: 20 * responsiveSize.width,
                                ),
                              ),
                              Text(
                                havm.trendingMovieList[0].title.toString(),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MovieDetailsScreen(id: havm.trendingMovieList[0].id!)),
                                  );
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
                  viewMoreInScreen:
                      const ViewMoreMovieScreen(type: "top-rated")),
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

  void showSideBar() {
    AnimationController sidebarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    Animation<Offset> slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: sidebarAnimationController,
      curve: Curves.linear,
    ));

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      enableDrag: false,
      transitionAnimationController: sidebarAnimationController,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top),
      builder: (BuildContext context) {
        return SlideTransition(
            position: slideAnimation, child: const MySidebar());
      },
    );
  }
}
