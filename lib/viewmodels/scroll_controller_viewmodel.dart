import 'package:flutter/cupertino.dart';

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
      notifyListeners();
    } else if (isTitleOnTop) {
      isTitleOnTop = false;
      notifyListeners();
    }
  }

  void dismissController() {
    bodyScrollController!.dispose();
    bodyScrollController!.removeListener(scrollControllerChanged);
  }
}
