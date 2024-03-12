import 'package:flutter/material.dart';

class BottomNavBarController extends ValueNotifier<int> {
  BottomNavBarController(this.controller) : super(0);
  final PageController controller;
  void changedSelection(
    int index,
  ) {
    value = index;
    controller.animateToPage(
      index,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.ease,
    );
  }
}
