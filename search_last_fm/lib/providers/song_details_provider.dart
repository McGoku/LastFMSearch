import 'package:search_last_fm/model/base_model.dart';
import 'package:search_last_fm/model/song_model.dart';
import 'package:search_last_fm/providers/details_provider.dart';
import 'package:search_last_fm/services/connection_service.dart';

class SongDetailsProvider extends DetailsProvider {
  SongDetailsProvider(BaseModel model) : super(model);

  @override
  Map<String, dynamic> getQueryParameters() {
    if (model.mbid.isNotEmpty) {
      return {
        'method': 'track.getInfo',
        'mbid': (model as SongModel).mbid,
        'api_key': ConnectionService.instance.apiKey,
        'format': 'json',
      };
    } else {
      return {
        'method': 'track.getInfo',
        'artist': model.title,
        'track': model.subtitle,
        'api_key': ConnectionService.instance.apiKey,
        'format': 'json',
      };
    }
  }

  @override
  BaseModel parseResults(Map<String, dynamic> json) {
    return SongModel.fromInfoJson(json["track"], model);
  }
}
