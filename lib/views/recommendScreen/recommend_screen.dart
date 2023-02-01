import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_mvvm/viewmodels/recommendScreenViewModel/recommend_api_viewmodel.dart';
import 'package:movie_app_mvvm/views/recommendScreen/recommend_screen_body.dart';
import 'package:provider/provider.dart';

import '../../utils/app_utils.dart';

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({super.key});

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  @override
  Widget build(BuildContext context) {
    AppUtils.mainContext = context;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: MultiProvider(
            providers: [ChangeNotifierProvider(create: (_) => RecommendApiViewModel())],
            child: const RecommendScreenBody()),
      ),
    );
  }
}
