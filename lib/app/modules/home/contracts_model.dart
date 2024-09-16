import 'package:musaneda/app/modules/home/musaneda_model.dart';
class Contracts {
  String? message;
  int? code;
  List<ContractsData>? data;

  Contracts({this.message, this.code, this.data});

  Contracts.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = <ContractsData>[];
      json['data'].forEach((v) {
        data!.add(ContractsData.fromJson(v));
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

class ContractsData {
  int? id;
  dynamic rentEnded;
  String? payTime;
  Package? package;
  User? user;
  MusanedaData? musaneda;
  Nationality? branch;
  double? price;
  int? isPaid;
  String? status;

  ContractsData(
      { this.id ,
        this.rentEnded,
        this.payTime,
        this.package,
        this.user,
        this.musaneda,
        this.branch,
        this.price,
        this.isPaid,
        this.status});

  ContractsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rentEnded = json['rent_ended'];
    payTime = json['pay_time'];
    package =
    json['package'] != null ? Package.fromJson(json['package']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    musaneda = json['musaneda'] != null
        ? MusanedaData.fromJson(json['musaneda'])
        : null;
    branch = json['branch'] != null
        ? Nationality.fromJson(json['branch'])
        : null;
    price = json['price'] != null ? double.parse(json['price'].toString()):null;
    isPaid = json['is_paid'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rent_ended'] = rentEnded;
    data['pay_time'] = payTime;
    if (package != null) {
      data['package'] = package!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (musaneda != null) {
      data['musaneda'] = musaneda!.toJson();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    data['price'] = price;
    data['is_paid'] = isPaid;
    data['status'] = status;
    return data;
  }
}

class Package {
  int? id;
  Name? name;
  dynamic price;
  int? duration;
  dynamic discount;
  dynamic tax;
  dynamic total;
  bool? forAllNationality;
  List? servants;

  Package(
      {this.id,
        this.name,
        this.price,
        this.duration,
        this.discount,
        this.tax,
        this.total,
        this.forAllNationality,
        this.servants});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    price = json['price'] != null ? double.parse(json['price'].toString()):null;
    duration = json['duration'];
    discount = json['discount'] != null ? double.parse(json['discount'].toString()):null;
    tax = json['tax'] != null ? double.parse(json['tax'].toString()):null;
    total = json['total'] != null ? double.parse(json['total'].toString()):null;
    forAllNationality = json['for_all_nationality'];
    if (json['servants'] != null) {
      servants = json['servants'] ;

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['price'] = price;
    data['duration'] = duration;
    data['discount'] = discount;
    data['tax'] = tax;
    data['total'] = total;
    data['for_all_nationality'] = forAllNationality;
    if (servants != null) {
      data['servants'] = servants!;
    }
    return data;
  }
}

class Name {
  String? ar;
  String? en;

  Name({this.ar, this.en});

  Name.fromJson(Map<String, dynamic> json) {
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

class User {
  int? id;
  String? name;
  String? phone;
  String? email;
  int? otp;
  String? createdAt;
  String? updatedAt;
  String? emailVerifiedAt;
  String? iqama;

  User(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.otp,
        this.createdAt,
        this.updatedAt,
        this.emailVerifiedAt,
        this.iqama});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    otp = json['otp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    emailVerifiedAt = json['email_verified_at'];
    iqama = json['iqama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['otp'] = otp;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['email_verified_at'] = emailVerifiedAt;
    data['iqama'] = iqama;
    return data;
  }
}
class Education {
  Name? name;

  Education({this.name});

  Education.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    return data;
  }
}

class Nationality {
  int? id;
  Name? name;

  Nationality({this.id, this.name});

  Nationality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    return data;
  }
}