import 'package:flutter/material.dart';

class FocusedOrbitsController extends ValueNotifier<List<int>> {
  FocusedOrbitsController() : super([]);

  void focusedOrbit(int index) {
    if (value.contains(index)) {
      value.remove(index);
      notifyListeners();
      return;
    }

    value.add(index);
    notifyListeners();
  }
}
