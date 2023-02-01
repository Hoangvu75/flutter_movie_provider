import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';
import 'package:movie_app_mvvm/views/viewMoreMovieScreen/view_more_movie_screen_body.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/scroll_controller_viewmodel.dart';
import '../../viewmodels/viewMoreMovieScreenViewModel/movie_api_viewmodel.dart';

class ViewMoreMovieScreen extends StatefulWidget {
  final String type;

  const ViewMoreMovieScreen({super.key, required this.type});

  @override
  State<ViewMoreMovieScreen> createState() => _ViewMoreMovieScreenState();
}

class _ViewMoreMovieScreenState extends State<ViewMoreMovieScreen> {
  @override
  Widget build(BuildContext context) {
    AppUtils.mainContext = context;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MovieApiViewModel(widget.type)),
            ChangeNotifierProvider(create: (_) => ScrollControllerViewModel(50 * responsiveSize.height)),
          ],
          child: const ViewMoreMovieScreenBody(),
        ),
      ),
    );
  }
}
