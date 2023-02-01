import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../utils/app_utils.dart';

class ScrollControllerViewModel with ChangeNotifier {
  ScrollController? bodyScrollController;
  bool isTitleOnTop = false;
  double scrollOffset;

  ScrollControllerViewModel(this.scrollOffset);

  void createScrollControlListener() {
    bodyScrollController = ScrollController();
    bodyScrollController?.addListener(scrollControllerChanged);
  }

  void scrollControllerChanged() {
    if (bodyScrollController!.offset > scrollOffset) {
      isTitleOnTop = true;
      if (kDebugMode) {
        print("on top");
      }
      notifyListeners();
    } else if (isTitleOnTop) {
      isTitleOnTop = false;
      if (kDebugMode) {
        print("out top");
      }
      notifyListeners();
    }
  }

  void onDispose() {
    bodyScrollController!.dispose();
    bodyScrollController!.removeListener(scrollControllerChanged);
  }
}
