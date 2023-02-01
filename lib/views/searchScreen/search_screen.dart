import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_mvvm/viewmodels/searchScreenViewModel/search_movie_api_viewmodel.dart';
import 'package:movie_app_mvvm/views/searchScreen/search_screen_body.dart';
import 'package:provider/provider.dart';

import '../../utils/app_utils.dart';
import '../../viewmodels/scroll_controller_viewmodel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    AppUtils.mainContext = context;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: MultiProvider(providers: [
          ChangeNotifierProvider(create: (_) => SearchMovieApiViewModel()),
          ChangeNotifierProvider(create: (_) => ScrollControllerViewModel(50 * responsiveSize.height))
        ], child: const SearchScreenBody()),
      ),
    );
  }
}
