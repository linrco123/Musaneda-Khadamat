import 'package:musaneda/app/modules/home/contracts_model.dart';

class Complaints {
  int? code;
  List<ComplaintsData>? data;

  Complaints({this.code, this.data});

  Complaints.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <ComplaintsData>[];
      json['data'].forEach((v) {
        data?.add(ComplaintsData.fromJson(v));
      });
    }
  }
}

class ComplaintsData {
  int? id;
  String? title;
  dynamic importance;
  String? description;
  dynamic type;
  ContractsData? contract;
  String? file;
  String? createdAt;

  ComplaintsData({
    this.id,
    this.contract,
    this.title,
    this.description,
    this.type,
    this.importance,
    this.file,
    this.createdAt
  });
  ComplaintsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contract = json['contract'] != null
        ? ContractsData.fromJson(json['contract'])
        : null;
    title = json['title'];
    description = json['description'];
    type = json['type'];
    importance = json['importance'];
    file = json['file'];
    createdAt = json['created_at'];
  }
}
