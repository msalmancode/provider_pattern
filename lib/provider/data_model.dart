import 'package:flutter/cupertino.dart';

class DataModel extends ChangeNotifier {
  final List<String> items = [];

  /// Add item
  void add(String item) {
    items.add(item);
    notifyListeners();
  }

  /// Delete All
  void removeAll() {
    items.clear();
    notifyListeners();
  }

  /// remove by index
  void removeByIndex(int index) {
    items.removeAt(index--);
    notifyListeners();
  }
}
