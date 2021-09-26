import 'package:flutter/material.dart';
import 'package:search_last_fm/services/search_service.dart';

enum Tabs {
  album,
  song,
  artist,
}

class HomeScreenProvider extends ChangeNotifier {
  HomeScreenProvider();

  bool shouldShowX = false;
  void submit(String text) async {
    SearchService.instance.searchText = text;
  }

  void changeText(String text) {
    if (shouldShowX) {
      if (text.length == 0) {
        shouldShowX = false;
        notifyListeners();
      }
    } else {
      if (text.length > 0) {
        shouldShowX = true;
        notifyListeners();
      }
    }
  }

  void clearText(TextEditingController controller) {
    controller.clear();
    shouldShowX = false;
    SearchService.instance.searchText = controller.text;
    notifyListeners();
  }
}
