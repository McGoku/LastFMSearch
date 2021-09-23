import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum Tabs {
  Album,
  Song,
  Artist,
}

class HomeScreenProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  final String rootURL = "http://ws.audioscrobbler.com/2.0/";
  // final String sharedSecret = "03e2c54367083871f924051dfa67f3b2";
  final String apiKey = "9a03fa28b4268fc39e837e431fa0c1fc";

  HomeScreenProvider() {
    init();
  }

  void init() {}

  Future<void> test() async {
    final queryParameters = {
      'method': 'album.search',
      'album': 'believe',
      'api_key': apiKey,
      'format': 'json',
    };
    Uri url = Uri.https("ws.audioscrobbler.com", "2.0/", queryParameters);

    print(url);
    var res = await http.get(url);

    print(res.statusCode);
    print(res.body);
  }

  void rebuild() {
    notifyListeners();
  }

  void clearText() {
    controller.clear();
    notifyListeners();
  }
}
