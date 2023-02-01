import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_mvvm/viewmodels/homeScreenViewModel/home_api_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../utils/app_utils.dart';
import 'home_screen_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AppUtils.mainContext = context;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: MultiProvider(
            providers: [ChangeNotifierProvider(create: (_) => HomeApiViewModel())], child: const HomeScreenBody()),
      ),
    );
  }
}
