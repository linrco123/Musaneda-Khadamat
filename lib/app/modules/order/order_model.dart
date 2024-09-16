class OrderModel {
  Data? data;
  String? msg;
  int? code;

  OrderModel({this.data, this.msg, this.code});

  OrderModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
    code = json['code'];
  }
}

class Data {
  dynamic price;
  dynamic packageId;
  dynamic branchId;
  dynamic servantId;
  dynamic isPaid;
  dynamic payTime;
  dynamic status;
  dynamic transactionId;
  dynamic userId;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic orderId;

  Data({
    this.price,
    this.packageId,
    this.branchId,
    this.servantId,
    this.isPaid,
    this.payTime,
    this.status,
    this.transactionId,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.orderId,
  });

  Data.fromJson(Map<String, dynamic> json) {

    price = json['price'];
    packageId = json['package_id'];
    branchId = json['branch_id'];
    servantId = json['servant_id'];
    isPaid = json['is_paid'];
    payTime = json['pay_time'];
    status = json['status'];
    transactionId = json['merchant_transction_id'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    orderId = json['id'];
  }
}




  
//   Map o = {
//   "data": {
//     "price": 4600,
//     "package_id": 1,
//     'branch_id': 3,
//     'servant_id': 702,
//     'is_paid': 1,
//     'pay_time': 2024,
//     'status': 1,
//     'merchant_transction_id': '2f514337-7030-442f-8381-7727c9ce36f9',
//     'user_id': 479,
//     'updated_at': '2024-07-04T07:35:45.000000Z',
//     'created_at': '2024-07-04T07:35:45.000000Z',
//     'id': 98
//   },
//   'message': 'order created successfully',
//   'code': 1
// };