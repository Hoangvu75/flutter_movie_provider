import 'package:flutter/cupertino.dart';
import 'package:movie_app_mvvm/services/api_service.dart';

import '../../apiResponse/movie_response.dart';
import '../../utils/app_utils.dart';

class MovieApiViewModel with ChangeNotifier {
  final String type;
  bool loading = true;
  List<Movie> movieList = [];
  String title_1 = "";
  String title_2 = "";

  MovieApiViewModel(this.type);

  Future<void> fetchMovies() async {
    switch (type) {
      case "trending-movies":
        final movieResponse = await ApiService.create().getTrendingMovies(apiKey);
        movieList = movieResponse.results!;
        title_1 = "Trending";
        title_2 = "Movies";
        break;
      case "trending-tvs":
        final movieResponse = await ApiService.create().getTrendingTvs(apiKey);
        movieList = movieResponse.results!;
        title_1 = "Trending";
        title_2 = "Tvs";
        break;
      case "upcoming":
        final movieResponse = await ApiService.create().getUpcomingMovies(apiKey);
        movieList = movieResponse.results!;
        title_1 = "Upcoming";
        title_2 = "Movies";
        break;
      case "popular":
        final movieResponse = await ApiService.create().getPopularMovies(apiKey);
        movieList = movieResponse.results!;
        title_1 = "Popular";
        title_2 = "Movies";
        break;
      case "top-rated":
        final movieResponse = await ApiService.create().getTopRatedMovies(apiKey);
        movieList = movieResponse.results!;
        title_1 = "Top Rated";
        title_2 = "Movies";
        break;
    }
    loading = false;
    notifyListeners();
  }

  void onDispose() {
    movieList = [];
    title_1 = "";
    title_2 = "";
  }
}
