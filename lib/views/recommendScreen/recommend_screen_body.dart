import 'package:flutter/material.dart';
import 'package:movie_app_mvvm/viewmodels/recommendScreenViewModel/recommend_api_viewmodel.dart';
import 'package:movie_app_mvvm/views/recommendScreen/components/movie_pageview.dart';
import 'package:provider/provider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'dart:math' as Math;

import '../../src/buildin_transformers.dart';

class RecommendScreenBody extends StatefulWidget {
  const RecommendScreenBody({super.key});

  @override
  State<RecommendScreenBody> createState() => _RecommendScreenBodyState();
}

class _RecommendScreenBodyState extends State<RecommendScreenBody> with TickerProviderStateMixin {
  late RecommendApiViewModel ravm;

  @override
  void initState() {
    ravm = Provider.of<RecommendApiViewModel>(context, listen: false);
    ravm.fetchTrendingMovies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ravm = Provider.of<RecommendApiViewModel>(context, listen: true);

    return (ravm.loadingTrendingMovie == true)
        ? Container()
        : TransformerPageView(
            loop: true,
            scrollDirection: Axis.horizontal,
            transformer: DepthPageTransformer(),
            itemBuilder: (BuildContext context, int index) {
              return MoviePageView(
                movie: ravm.trendingMovieList[index],
                key: ValueKey(index),
              );
            },
            itemCount: ravm.trendingMovieList.length);
  }
}
