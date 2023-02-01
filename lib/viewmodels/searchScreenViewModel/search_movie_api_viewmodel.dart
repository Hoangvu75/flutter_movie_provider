import 'package:flutter/cupertino.dart';
import 'package:movie_app_mvvm/services/api_service.dart';

import '../../apiResponse/movie_response.dart';
import '../../utils/app_utils.dart';

class SearchMovieApiViewModel with ChangeNotifier {
  bool loadingSearchMovie = true;
  List<Movie> searchMovieList = [];

  Future<void> fetchSearchMovies(String movieName) async {
    final response = await ApiService.create().getSearchMovies(apiKey, movieName, true);
    searchMovieList = response.results!;
    loadingSearchMovie = false;
    notifyListeners();
  }
}
