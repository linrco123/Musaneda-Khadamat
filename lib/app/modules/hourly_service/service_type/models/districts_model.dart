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
        data!.add(new DistrictsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
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
    title = json['title'] != null ? new TitleLang.fromJson(json['title']) : null;
    longitude = json['longitude'];
    latitude = json['latitude'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['city'] = this.city;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar'] = this.ar;
    data['en'] = this.en;
    return data;
  }
}