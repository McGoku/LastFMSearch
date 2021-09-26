import 'package:search_last_fm/model/base_model.dart';

class AlbumModel extends BaseModel {
  String _name;
  String _artist;
  String _image;
  String _mbid;

  String _published;
  String _summary;

  AlbumModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    this._name = json["name"] ?? "";
    this._artist = json["artist"] ?? "";
    if (json["image"] != null && json["image"].length > 0) {
      this._image = json["image"].last["#text"];
    }
    this._mbid = json["mbid"] ?? "";

    //extended params
    if (json["wiki"] != null) {
      this._published = json["wiki"]["published"] ?? "";
      this._summary = json["wiki"]["summary"] ?? "";
    } else {
      this._published = "additional info is missing";
      this._summary = "";
    }
  }

  @override
  String get imageURL => _image;

  @override
  String get subtitle => _name;

  @override
  String get title => _artist;

  @override
  String get published => _published;

  @override
  String get summary => _summary;

  @override
  String get mbid => _mbid;
}
