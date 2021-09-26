import 'package:search_last_fm/model/album_model.dart';
import 'package:search_last_fm/model/base_model.dart';
import 'package:search_last_fm/providers/details_provider.dart';
import 'package:search_last_fm/services/connection_service.dart';

class AlbumDetailsProvider extends DetailsProvider {
  AlbumDetailsProvider(BaseModel model) : super(model);

  @override
  Map<String, dynamic> getQueryParameters() {
    if (model.mbid.isNotEmpty) {
      return {
        'method': 'album.getInfo',
        'mbid': model.mbid,
        'api_key': ConnectionService.instance.apiKey,
        'format': 'json',
      };
    } else {
      return {
        'method': 'album.getInfo',
        'artist': model.title,
        'album': model.subtitle,
        'api_key': ConnectionService.instance.apiKey,
        'format': 'json',
      };
    }
  }

  @override
  BaseModel parseResults(Map<String, dynamic> json) {
    return AlbumModel.fromJson(json["album"]);
  }
}
