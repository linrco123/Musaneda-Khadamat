class PackagesModel {
  List<PackageData>? data;
  String? msg;
  int? code;

  PackagesModel({this.data, this.msg, this.code});

  PackagesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PackageData>[];
      json['data'].forEach((v) {
        data!.add(PackageData.fromJson(v));
      });
    }
    msg = json['msg'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['code'] = code;
    return data;
  }
}

class PackageData {
  int? id;
  int? countryId;
  String? country;
  String? shiftText;
  String? shift;
  int? cost;
  int? startFrom;
  int? endTo;
  String? title;
  int? duration;
  String? status;

  PackageData(
      {this.id,
      this.countryId,
      this.country,
      this.shiftText,
      this.shift,
      this.cost,
      this.startFrom,
      this.endTo,
      this.title,
      this.duration , 
      this.status
      });

  PackageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    country = json['country'];
    shiftText = json['shift_text'];
    shift = json['shift'];
    cost = json['cost'];
    startFrom = json['start_from'];
    endTo = json['end_to'];
    title = json['title'];
    duration = json['duration'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_id'] = countryId;
    data['country'] = country;
    data['shift_text'] = shiftText;
    data['shift'] = shift;
    data['cost'] = cost;
    data['start_from'] = startFrom;
    data['end_to'] = endTo;
    data['title'] = title;
    data['duration'] = duration;
    data['status'] = status;
    return data;
  }
}