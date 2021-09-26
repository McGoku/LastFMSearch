import 'package:search_last_fm/model/artist_model.dart';
import 'package:search_last_fm/model/base_model.dart';
import 'package:search_last_fm/providers/results_provider.dart';
import 'package:search_last_fm/services/connection_service.dart';

class ArtistResultsProvider extends ResultsProvider {
  ArtistResultsProvider() : super();

  @override
  Map<String, dynamic> getQueryParameters(String textParam) {
    return {
      'method': 'artist.search',
      'artist': textParam,
      'api_key': ConnectionService.instance.apiKey,
      'format': 'json',
      'page': '$nextPage',
      'limit': '$limit',
    };
  }

  @override
  List<BaseModel> parseResults(Map<String, dynamic> json) {
    List<ArtistModel> result = [];
    if (json["results"] != null &&
        json["results"]["artistmatches"] != null &&
        json["results"]["artistmatches"]["artist"] != null &&
        json["results"]["artistmatches"]["artist"].length > 0) {
      totalResults = int.tryParse(json["results"]["opensearch:totalResults"]);
      for (var a in json["results"]["artistmatches"]["artist"]) {
        result.add(ArtistModel.fromJson(a));
      }
    }
    return result;
  }
}
