import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:search_last_fm/model/base_model.dart';
import 'package:search_last_fm/services/connection_service.dart';
import 'package:search_last_fm/services/search_service.dart';
import 'package:http/http.dart' as http;

enum ResultsState {
  idle,
  loading,
  noResults,
  results,
  error,
  disposed,
}

abstract class ResultsProvider extends ChangeNotifier {
  ResultsState _state = ResultsState.idle;
  ResultsState get state => _state;
  bool get isDisposed => _state == ResultsState.disposed;
  set state(ResultsState newValue) {
    if (!isDisposed) {
      _state = newValue;
      notifyListeners();
    }
  }

  List<BaseModel> results;

  ResultsProvider() {
    SearchService.instance.addListener(listenService);
  }

  @override
  void dispose() {
    SearchService.instance.removeListener(listenService);
    state = ResultsState.disposed;
    super.dispose();
  }

  Map<String, dynamic> getQueryParameters(String textParam);
  List<BaseModel> parseResults(Map<String, dynamic> json);

  void listenService() async {
    String textParam = SearchService.instance.searchText;
    if (textParam.isNotEmpty) {
      state = ResultsState.loading;

      Uri url = Uri.https(ConnectionService.instance.authority, ConnectionService.instance.path, getQueryParameters(textParam));

      try {
        var res = await http.get(url);
        if (SearchService.instance.searchText != textParam) return;
        if (res.statusCode == 200) {
          results = parseResults(jsonDecode(res.body));
          if (results.length > 0) {
            state = ResultsState.results;
          } else {
            state = ResultsState.noResults;
          }
        } else {
          state = ResultsState.error;
        }
      } catch (e) {
        print("there was ana error while fetching data $e");
        state = ResultsState.error;
      }
    } else {
      state = ResultsState.idle;
    }
  }
}
