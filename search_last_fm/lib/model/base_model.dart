abstract class BaseModel {
  BaseModel.fromJson(Map<String, dynamic> json);

  String get imageURL;
  String get title;
  String get subtitle;
  String get mbid;

  String get published;
  String get summary;
}
