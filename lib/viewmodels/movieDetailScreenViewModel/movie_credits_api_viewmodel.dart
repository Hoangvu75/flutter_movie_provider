import 'package:flutter/cupertino.dart';

import '../../apiResponse/movie_credits_response.dart';
import '../../services/api_service.dart';
import '../../utils/app_utils.dart';

class MovieCreditsApiViewModel with ChangeNotifier {
  final int movieId;
  bool loading = true;
  late MovieCreditsResponse movieCredits;

  MovieCreditsApiViewModel(this.movieId);

  Future<void> fetchMovieCredits() async {
    final movieCreditsResponse = await ApiService.createWithErrorHandler(() {
      Navigator.pop(AppUtils.mainContext);
    }, () {
      Navigator.pop(AppUtils.mainContext);
    }, "This concept is not available.")
        .getMovieCredits(movieId, apiKey);
    movieCredits = movieCreditsResponse;
    loading = false;
    notifyListeners();
  }
}
