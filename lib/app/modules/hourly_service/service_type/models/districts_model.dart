class DistrictModel {
  String? message;
  int? code;
  List<DistrictsData>? data;

  DistrictModel({this.message, this.code, this.data});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = <DistrictsData>[];
      json['data'].forEach((v) {
        data!.add(DistrictsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistrictsData {
  int? id;
  TitleLang? title;
  String? longitude;
  String? latitude;
  int? city;

  DistrictsData({this.id, this.title, this.longitude, this.latitude, this.city});

  DistrictsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null ? TitleLang.fromJson(json['title']) : null;
    longitude = json['longitude'];
    latitude = json['latitude'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['city'] = city;
    return data;
  }
}

class TitleLang {
  String? ar;
  String? en;

  TitleLang({this.ar, this.en});

  TitleLang.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ar'] = ar;
    data['en'] = en;
    return data;
  }
}