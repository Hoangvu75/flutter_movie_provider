import 'package:flutter/cupertino.dart';
import 'package:movie_app_mvvm/services/api_service.dart';

import '../../apiResponse/movie_response.dart';
import '../../utils/app_utils.dart';

class RecommendApiViewModel with ChangeNotifier {
  bool loadingTrendingMovie = true;
  List<Movie> trendingMovieList = [];

  Future<void> fetchTrendingMovies() async {
    final response = await ApiService.create().getTrendingMovies(apiKey);
    trendingMovieList = response.results!;
    loadingTrendingMovie = false;
    notifyListeners();
  }
}
