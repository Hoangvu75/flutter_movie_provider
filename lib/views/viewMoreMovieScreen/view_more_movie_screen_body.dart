import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app_mvvm/src/PColor.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';
import 'package:movie_app_mvvm/viewmodels/viewMoreMovieScreenViewModel/movie_api_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../viewmodels/scroll_controller_viewmodel.dart';
import 'components/view_more_movie_item_widget.dart';

class ViewMoreMovieScreenBody extends StatefulWidget {
  const ViewMoreMovieScreenBody({super.key});

  @override
  State<ViewMoreMovieScreenBody> createState() => _ViewMoreMovieScreenBodyState();
}

class _ViewMoreMovieScreenBodyState extends State<ViewMoreMovieScreenBody> {
  late MovieApiViewModel mavm;
  late ScrollControllerViewModel scvm;

  @override
  void initState() {
    mavm = Provider.of<MovieApiViewModel>(context, listen: false);
    scvm = Provider.of<ScrollControllerViewModel>(context, listen: false);

    mavm.fetchMovies();
    scvm.createScrollControlListener();

    super.initState();
  }

  @override
  void dispose() {
    mavm.onDispose();
    scvm.onDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mavm = Provider.of<MovieApiViewModel>(context, listen: true);
    scvm = Provider.of<ScrollControllerViewModel>(context, listen: true);

    return RefreshIndicator(
      color: PColors.darkBlue,
      onRefresh: () async {
        await mavm.fetchMovies();
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
          opacity: mavm.loading ? 0 : 1,
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
                expandedHeight: 175 * responsiveSize.height,
                elevation: 0,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: scvm.isTitleOnTop ? null : EdgeInsets.only(left: 20 * responsiveSize.width),
                  title: Text(
                    scvm.isTitleOnTop
                        ? "${mavm.title_1} ${mavm.title_2}"
                        : "${mavm.title_1}\n${mavm.title_2}",
                    style: TextStyle(
                      color: PColors.darkBlue,
                      fontFamily: scvm.isTitleOnTop ? Assets.fontsSVNGilroyBold : Assets.fontsSVNGilroyMedium,
                      fontSize: scvm.isTitleOnTop ? 16 * responsiveSize.width : 24 * responsiveSize.width,
                    ),
                  ),
                  centerTitle: scvm.isTitleOnTop ? true : false,
                ),
                backgroundColor: scvm.isTitleOnTop ? Colors.white : Colors.transparent,
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 25,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: mavm.movieList.length,
                  (BuildContext context, int index) {
                    return ViewMoreMovieItem(movie: mavm.movieList[index], key: ValueKey(index));
                  },
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
