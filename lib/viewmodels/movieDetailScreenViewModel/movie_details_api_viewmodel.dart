import 'package:flutter/cupertino.dart';
import 'package:movie_app_mvvm/apiResponse/movie_details_response.dart';

import '../../services/api_service.dart';
import '../../utils/app_utils.dart';

class MovieDetailsApiViewModel with ChangeNotifier {
  void onApiError() {
    Navigator.pop(AppUtils.mainContext);
  }

  final int movieId;
  bool loading = true;
  late MovieDetailsResponse movieDetail;

  MovieDetailsApiViewModel(this.movieId);

  Future<void> fetchMovieDetails() async {
    final movieDetailResponse = await ApiService.createWithErrorHandler(() {
      Navigator.pop(AppUtils.mainContext);
    }, () {
      Navigator.pop(AppUtils.mainContext);
    }, "This concept is not available.").getMovieDetails(movieId, apiKey);
    movieDetail = movieDetailResponse;
    loading = false;
    notifyListeners();
  }
}
