import 'package:flutter/material.dart';
import 'package:search_last_fm/services/search_service.dart';

enum Tabs {
  album,
  song,
  artist,
}

class HomeScreenProvider extends ChangeNotifier {
  HomeScreenProvider();

  void submit(String text) async {
    SearchService.instance.searchText = text;
  }

  //TODO: preimenuj ovo
  void changeText(String text) {
    notifyListeners();
  }

  void clearText(TextEditingController controller) {
    controller.clear();
    SearchService.instance.searchText = controller.text;
    notifyListeners();
  }
}
