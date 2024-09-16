class TransactionIdModel {
  Data? data;
  String? msg;
  int? code;

  TransactionIdModel({this.data, this.msg, this.code});

  TransactionIdModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
    code = json['code'];
  }

}

class Data {
  String? orderId;
  String? transactionId;
  int? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.orderId,
        this.transactionId,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    transactionId = json['transaction_id'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

}