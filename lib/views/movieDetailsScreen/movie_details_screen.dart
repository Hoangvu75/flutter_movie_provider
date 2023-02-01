import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';
import 'package:movie_app_mvvm/viewmodels/movieDetailScreenViewModel/movie_credits_api_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/movieDetailScreenViewModel/movie_details_api_viewmodel.dart';
import '../../viewmodels/scroll_controller_viewmodel.dart';
import 'movie_details_screen_body.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int id;

  const MovieDetailsScreen({super.key, required this.id});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    AppUtils.mainContext = context;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: MultiProvider(providers: [
          ChangeNotifierProvider(create: (_) => MovieDetailsApiViewModel(widget.id)),
          ChangeNotifierProvider(create: (_) => MovieCreditsApiViewModel(widget.id)),
          ChangeNotifierProvider(create: (_) => ScrollControllerViewModel(200 * responsiveSize.height)),
        ], child: const MovieDetailsScreenBody()),
      ),
    );
  }
}
