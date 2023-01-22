import 'package:flutter/cupertino.dart';
import 'package:movie_app_mvvm/services/api_service.dart';

import '../../apiResponse/movie_response.dart';
import '../../utils/app_utils.dart';

class HomeApiViewModel with ChangeNotifier {
  bool loadingTrendingMovie = true;
  List<Movie> trendingMovieList = [];

  Future<void> fetchTrendingMovies() async {
    final response = await ApiService.create().getTrendingMovies(apiKey);
    trendingMovieList = response.results!;
    loadingTrendingMovie = false;
    notifyListeners();
  }

  bool loadingTrendingTv = true;
  List<Movie> trendingTvList = [];

  Future<void> fetchTrendingTvs() async {
    final response = await ApiService.create().getTrendingTvs(apiKey);
    trendingTvList = response.results!;
    loadingTrendingTv = false;
    notifyListeners();
  }

  bool loadingUpcoming = true;
  List<Movie> upcomingList = [];

  Future<void> fetchUpcomingMovies() async {
    final response = await ApiService.create().getUpcomingMovies(apiKey);
    upcomingList = response.results!;
    loadingUpcoming = false;
    notifyListeners();
  }

  bool loadingPopular = true;
  List<Movie> popularList = [];

  Future<void> fetchPopularMovies() async {
    final response = await ApiService.create().getPopularMovies(apiKey);
    popularList = response.results!;
    loadingPopular = false;
    notifyListeners();
  }

  bool loadingTopRated = true;
  List<Movie> topRatedList = [];

  Future<void> fetchTopRatedMovies() async {
    final response = await ApiService.create().getTopRatedMovies(apiKey);
    topRatedList = response.results!;
    loadingTopRated = false;
    notifyListeners();
  }
}
