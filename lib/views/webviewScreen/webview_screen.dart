import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_mvvm/views/webviewScreen/webview_screen_body.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../generated/assets.dart';
import '../../utils/app_utils.dart';
import 'components/navigation_controls.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> with WidgetsBindingObserver {
  var loadingPercentage = 0;
  late final WebViewController controller;
  String url = "https://www.themoviedb.org/";
  bool isUrlFocused = false;
  TextEditingController urlController = TextEditingController();
  FocusNode urlFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
        onNavigationRequest: (navigation) {
          final host = Uri.parse(navigation.url).host;
          setState(() {
            url = navigation.url;
          });
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(
        Uri.parse(url),
      );
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.mainContext = context;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.black,
          title: (isUrlFocused == true)
              ? TextField(
                  focusNode: urlFocusNode,
                  controller: urlController,
                  autofocus: true,
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: Assets.fontsSVNGilroyBold,
                    fontSize: 15 * responsiveSize.width,
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      url = value;
                      isUrlFocused = false;
                      bool validURL = Uri.parse(value).isAbsolute;
                      if (validURL) {
                        controller.loadRequest(Uri.parse(value));
                      } else {
                        controller.loadRequest(Uri.parse("https://www.google.com.vn/search?q=$value&hl=vi"));
                      }
                    });
                  },
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      isUrlFocused = true;
                      urlController.text = url;
                      urlController.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: url.length,
                      );
                    });
                  },
                  child: Text.rich(
                    TextSpan(
                      text: url,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: Assets.fontsSVNGilroyBold,
                        fontSize: 15 * responsiveSize.width,
                      ),
                    ),
                    maxLines: 2,
                  ),
                ),
          actions: [
            NavigationControls(
              controller: controller,
              url: url,
            ),
          ],
        ),
        body: WebviewScreenBody(
          controller: controller,
          loadingPercentage: loadingPercentage,
        ),
      ),
    );
  }
}
