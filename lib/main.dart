import 'package:flutter/material.dart';
import 'package:movie_app_mvvm/splash.dart';
import 'package:movie_app_mvvm/src/PColor.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';
import 'package:movie_app_mvvm/views/homeScreen/home_screen.dart';

import 'generated/assets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MainScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          const HomeScreen(),
          Container(),
          Container(),
          Container(),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 50 * responsiveSize.width,
        height: 50 * responsiveSize.height,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: PColors.blueMain,
          onPressed: () {},
          child: Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
            size: 30 * responsiveSize.width,
          ), //icon inside button
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: PColors.backgroundBottom,
        shape: const CircularNotchedRectangle(),
        notchMargin: 7 * responsiveSize.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home,
                        color: _currentIndex == 0
                            ? PColors.lightOrange
                            : PColors.blueMain),
                    Text(
                      "Home",
                      style: TextStyle(
                        color: _currentIndex == 0
                            ? PColors.lightOrange
                            : PColors.blueMain,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                        fontSize: 10 * responsiveSize.width,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search,
                        color: _currentIndex == 1
                            ? PColors.lightOrange
                            : PColors.blueMain),
                    Text(
                      "Search",
                      style: TextStyle(
                        color: _currentIndex == 1
                            ? PColors.lightOrange
                            : PColors.blueMain,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                        fontSize: 10 * responsiveSize.width,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.save_alt,
                        color: _currentIndex == 2
                            ? PColors.lightOrange
                            : PColors.blueMain),
                    Text(
                      "Saved",
                      style: TextStyle(
                        color: _currentIndex == 2
                            ? PColors.lightOrange
                            : PColors.blueMain,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                        fontSize: 10 * responsiveSize.width,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_circle_outlined,
                        color: _currentIndex == 3
                            ? PColors.lightOrange
                            : PColors.blueMain),
                    Text(
                      "Account",
                      style: TextStyle(
                        color: _currentIndex == 3
                            ? PColors.lightOrange
                            : PColors.blueMain,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                        fontSize: 10 * responsiveSize.width,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
