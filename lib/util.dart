import 'package:flutter/material.dart';

class CustomNotifier extends ChangeNotifier {
  void notify() => notifyListeners();
}
