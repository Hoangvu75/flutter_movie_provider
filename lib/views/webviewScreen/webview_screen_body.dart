import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebviewScreenBody extends StatefulWidget {
  final WebViewController controller;
  final int loadingPercentage;
  const WebviewScreenBody({super.key, required this.controller, required this.loadingPercentage});

  @override
  State<WebviewScreenBody> createState() => _WebviewScreenBodyState();
}

class _WebviewScreenBodyState extends State<WebviewScreenBody> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return
      (widget.loadingPercentage < 100)
      ? SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SizedBox(
            height: 50.0,
            width: 50.0,
            child: CircularProgressIndicator(
              value: widget.loadingPercentage / 100.0,
            ),
          ),
        ),
      )
      : WebViewWidget(
        controller: widget.controller,
      );
  }
}
