import 'package:search_last_fm/model/base_model.dart';
import 'package:search_last_fm/model/song_model.dart';
import 'package:search_last_fm/providers/results_provider.dart';
import 'package:search_last_fm/services/connection_service.dart';

class SongResultsProvider extends ResultsProvider {
  SongResultsProvider() : super();

  @override
  Map<String, dynamic> getQueryParameters(String textParam) {
    return {
      'method': 'track.search',
      'track': textParam,
      'api_key': ConnectionService.instance.apiKey,
      'format': 'json',
    };
  }

  @override
  List<BaseModel> parseResults(Map<String, dynamic> json) {
    List<SongModel> result = [];
    if (json["results"] != null &&
        json["results"]["trackmatches"] != null &&
        json["results"]["trackmatches"]["track"] != null &&
        json["results"]["trackmatches"]["track"].length > 0) {
      for (var a in json["results"]["trackmatches"]["track"]) {
        result.add(SongModel.fromJson(a));
      }
    }
    return result;
  }
}
