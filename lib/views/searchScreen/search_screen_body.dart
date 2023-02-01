import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';
import 'package:movie_app_mvvm/viewmodels/searchScreenViewModel/search_movie_api_viewmodel.dart';
import 'package:movie_app_mvvm/views/searchScreen/components/search_movie_item_widget.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../src/PColor.dart';
import '../../viewmodels/scroll_controller_viewmodel.dart';

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key});

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> with TickerProviderStateMixin {
  late SearchMovieApiViewModel smavm;
  late ScrollControllerViewModel scvm;

  @override
  void initState() {
    smavm = Provider.of<SearchMovieApiViewModel>(context, listen: false);
    scvm = Provider.of<ScrollControllerViewModel>(context, listen: false);

    scvm.createScrollControlListener();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    smavm = Provider.of<SearchMovieApiViewModel>(context, listen: true);
    scvm = Provider.of<ScrollControllerViewModel>(context, listen: true);

    return RefreshIndicator(
      color: PColors.darkBlue,
      onRefresh: () async {},
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
        child: CustomScrollView(
          controller: scvm.bodyScrollController,
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              leadingWidth: 70,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 100 * responsiveSize.height,
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: scvm.isTitleOnTop ? Colors.white : Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: scvm.isTitleOnTop ? null : EdgeInsets.only(left: 20 * responsiveSize.width),
                title: Text(
                  "Search for movies",
                  style: TextStyle(
                    color: PColors.darkBlue,
                    fontFamily: scvm.isTitleOnTop ? Assets.fontsSVNGilroyBold : Assets.fontsSVNGilroyMedium,
                    fontSize: scvm.isTitleOnTop ? 16 * responsiveSize.width : 24 * responsiveSize.width,
                  ),
                ),
                centerTitle: scvm.isTitleOnTop ? true : false,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 25 * responsiveSize.height,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.fromLTRB(15 * responsiveSize.width, 0, 15 * responsiveSize.width, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10 * responsiveSize.width),
                ),
                child: TextField(
                    onSubmitted: (value) {
                      smavm.fetchSearchMovies(value);
                    },
                    controller: TextEditingController(),
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    )),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50 * responsiveSize.height,
              ),
            ),
            (smavm.searchMovieList == [])
                ? Container()
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: smavm.searchMovieList.length,
                      (BuildContext context, int index) {
                        return SearchMovieItemWidget(
                            movie: smavm.searchMovieList[index], key: ValueKey(index));
                      },
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
    );
  }
}
