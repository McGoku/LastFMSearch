import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:search_last_fm/model/base_model.dart';
import 'package:http/http.dart' as http;
import 'package:search_last_fm/services/connection_service.dart';

enum DetailsState {
  loading,
  error,
  result,
  disposed,
}

abstract class DetailsProvider extends ChangeNotifier {
  BaseModel model;
  DetailsState _state = DetailsState.loading;
  DetailsState get state => _state;
  bool get isDisposed => _state == DetailsState.disposed;
  set state(DetailsState newValue) {
    if (!isDisposed) {
      _state = newValue;
      notifyListeners();
    }
  }

  DetailsProvider(this.model) {
    init();
  }

  @override
  void dispose() {
    _state = DetailsState.disposed;
    super.dispose();
  }

  Map<String, dynamic> getQueryParameters();
  BaseModel parseResults(Map<String, dynamic> json);

  void init() async {
    Uri url = Uri.https(ConnectionService.instance.authority, ConnectionService.instance.path, getQueryParameters());

    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        model = parseResults(jsonDecode(res.body));
        state = DetailsState.result;
      } else {
        state = DetailsState.error;
      }
    } catch (e) {
      print("there was ana error while fetching data $e");
      state = DetailsState.error;
    }
  }
}
