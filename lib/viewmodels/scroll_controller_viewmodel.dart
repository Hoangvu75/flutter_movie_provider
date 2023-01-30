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
      print("ontop");
      notifyListeners();
    } else if (isTitleOnTop) {
      isTitleOnTop = false;
      print("outtop");
      notifyListeners();
    }
  }

  void dismissController() {
    bodyScrollController!.dispose();
    bodyScrollController!.removeListener(scrollControllerChanged);
  }
}
