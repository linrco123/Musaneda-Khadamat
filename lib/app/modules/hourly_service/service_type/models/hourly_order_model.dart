class HourlyOrderModel {
  String? msg;
  Data? data;
  int? code;

  HourlyOrderModel({this.msg, this.data, this.code});

  HourlyOrderModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class Data {
  Order? order;

  Data({this.order});

  Data.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}

class Order {
  dynamic countryId;
  dynamic fromDate;
  dynamic visits;
  dynamic toDate;
  dynamic servantCount;
  dynamic userAddressId;
  dynamic cost;
  dynamic userId;
  dynamic packageId;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic id;

  Order(
      {this.countryId,
      this.fromDate,
      this.visits,
      this.toDate,
      this.servantCount,
      this.userAddressId,
      this.cost,
      this.userId,
      this.packageId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Order.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    fromDate = json['from_date'];
    visits = json['visits'];
    toDate = json['to_date'];
    servantCount = json['servant_count'];
    userAddressId = json['user_address_id'];
    cost = json['cost'];
    userId = json['user_id'];
    packageId = json['package_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['from_date'] = fromDate;
    data['visits'] = visits;
    data['to_date'] = toDate;
    data['servant_count'] = servantCount;
    data['user_address_id'] = userAddressId;
    data['cost'] = cost;
    data['user_id'] = userId;
    data['package_id'] = packageId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}