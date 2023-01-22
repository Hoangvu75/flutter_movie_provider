import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app_mvvm/apiResponse/movie_credits_response.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

import '../apiResponse/movie_details_response.dart';
import '../apiResponse/movie_response.dart';
import '../generated/assets.dart';
import '../utils/app_functions.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static final CustomDialog _customDialog = CustomDialog();

  static ApiService create() {
    final dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options.connectTimeout = 60000;
    dio.interceptors.add(PrettyDioLogger());

    return ApiService(
      dio,
      baseUrl: baseUrl,
    );
  }

  static ApiService createWithErrorHandler(Function cancelCallback,
      Function confirmCallback, String errorContent) {
    final dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options.connectTimeout = 60000;
    dio.interceptors.add(PrettyDioLogger());

    dio.interceptors.add(InterceptorsWrapper(
        onError: (DioError e, ErrorInterceptorHandler handler) => {
              if (e.response != null && e.response?.statusCode != 200)
                {
                  _customDialog.showErrorDialog(
                      AppUtils.mainContext,
                      SvgPicture.asset(Assets.svgsIcSystemError),
                      "${e.response!.statusCode.toString()} ${e.response!.statusMessage.toString()}",
                      errorContent,
                      cancelCallback,
                      confirmCallback)
                }
            }));

    return ApiService(
      dio,
      baseUrl: baseUrl,
    );
  }

  // Get movie list
  @GET("/trending/movie/day")
  Future<MovieResponse> getTrendingMovies(@Query("api_key") String apiKey);

  @GET("/trending/tv/day")
  Future<MovieResponse> getTrendingTvs(@Query("api_key") String apiKey);

  @GET("/movie/upcoming")
  Future<MovieResponse> getUpcomingMovies(@Query("api_key") String apiKey);

  @GET("/movie/popular")
  Future<MovieResponse> getPopularMovies(@Query("api_key") String apiKey);

  @GET("/movie/top_rated")
  Future<MovieResponse> getTopRatedMovies(@Query("api_key") String apiKey);

  // Get movie details
  @GET("movie/{id}")
  Future<MovieDetailsResponse> getMovieDetails(
      @Path("id") int id, @Query("api_key") String apiKey);

  @GET("movie/{id}/credits")
  Future<MovieCreditsResponse> getMovieCredits(
      @Path("id") int id, @Query("api_key") String apiKey);
}
