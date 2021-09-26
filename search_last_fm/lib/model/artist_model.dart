import 'package:search_last_fm/model/base_model.dart';

class ArtistModel extends BaseModel {
  String _name;
  String _listeners;
  String _mbid;
  String _image;

  String _published;
  String _summary;

  ArtistModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    this._name = json["name"] ?? "";
    this._listeners = json["listeners"] ?? "";
    this._mbid = json["mbid"] ?? "";

    if (json["image"] != null && json["image"].length > 0) {
      this._image = json["image"].last["#text"];
    }
  }

  ArtistModel.fromInfoJson(Map<String, dynamic> json) : super.fromJson(json) {
    this._name = json["name"] ?? "";
    this._mbid = json["mbid"] ?? "";
    if (json["image"] != null && json["image"].length > 0) {
      this._image = json["image"].last["#text"];
    }

    if (json["bio"] != null) {
      this._published = json["bio"]["published"] ?? "";
      this._summary = json["bio"]["summary"] ?? "";
    } else {
      this._published = "additional info is missing";
      this._summary = "";
    }

    if (json["stats"] != null) {
      this._listeners = json["stats"]["listeners"] ?? "";
    }
  }

  @override
  String get imageURL => _image;

  @override
  String get subtitle => _listeners;

  @override
  String get title => _name;

  @override
  String get published => _published;

  @override
  String get summary => _summary;

  @override
  String get mbid => _mbid;
}
