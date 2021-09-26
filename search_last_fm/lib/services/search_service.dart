import 'package:flutter/material.dart';
import 'package:search_last_fm/providers/home_screen_provider.dart';

class SearchService extends ChangeNotifier {
  static SearchService _instance;
  static SearchService get instance => _instance ?? SearchService();

  SearchService() {
    _instance = this;
  }

  String _searchText = "";
  String get searchText => _searchText;
  set searchText(String newValue) {
    _searchText = newValue;
    notifyListeners();
  }

  Tabs _activeTab;
  Tabs get activeTab => _activeTab;
  set activeTab(Tabs newValue) {
    _activeTab = newValue;
    notifyListeners();
  }
}
