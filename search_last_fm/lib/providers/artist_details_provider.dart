import 'package:search_last_fm/model/artist_model.dart';
import 'package:search_last_fm/model/base_model.dart';
import 'package:search_last_fm/providers/details_provider.dart';
import 'package:search_last_fm/services/connection_service.dart';

class ArtistDetailsProvider extends DetailsProvider {
  ArtistDetailsProvider(BaseModel model) : super(model);

  @override
  Map<String, dynamic> getQueryParameters() {
    if (model.mbid.isNotEmpty) {
      return {
        'method': 'artist.getInfo',
        'mbid': model.mbid,
        'api_key': ConnectionService.instance.apiKey,
        'format': 'json',
      };
    } else {
      return {
        'method': 'artist.getInfo',
        'artist': model.title,
        'api_key': ConnectionService.instance.apiKey,
        'format': 'json',
      };
    }
  }

  @override
  BaseModel parseResults(Map<String, dynamic> json) {
    return ArtistModel.fromInfoJson(json["artist"]);
  }
}
