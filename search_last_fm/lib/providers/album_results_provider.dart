import 'package:search_last_fm/model/album_model.dart';
import 'package:search_last_fm/model/base_model.dart';
import 'package:search_last_fm/providers/results_provider.dart';
import 'package:search_last_fm/services/connection_service.dart';

class AlbumResultsProvider extends ResultsProvider {
  AlbumResultsProvider() : super();

  @override
  Map<String, dynamic> getQueryParameters(String textParam) {
    return {
      'method': 'album.search',
      'album': textParam,
      'api_key': ConnectionService.instance.apiKey,
      'format': 'json',
      'page': '$nextPage',
      'limit': '$limit',
    };
  }

  @override
  List<BaseModel> parseResults(Map<String, dynamic> json) {
    List<AlbumModel> result = [];
    if (json["results"] != null &&
        json["results"]["albummatches"] != null &&
        json["results"]["albummatches"]["album"] != null &&
        json["results"]["albummatches"]["album"].length > 0) {
      totalResults = int.tryParse(json["results"]["opensearch:totalResults"]);
      for (var a in json["results"]["albummatches"]["album"]) {
        result.add(AlbumModel.fromJson(a));
      }
    }
    return result;
  }
}
