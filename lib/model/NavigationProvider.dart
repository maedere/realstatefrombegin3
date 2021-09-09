import 'package:flutter/cupertino.dart';

class NavigationProviderModel with ChangeNotifier { //                          <--- MyModel
  int index = 2;
  void changeIndex(int index) {
    this.index=index;
    notifyListeners();
  }
}