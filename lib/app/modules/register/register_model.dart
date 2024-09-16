class Register {
  int? code;
  RegisterData? data;
  String? message;

  Register({this.code, this.data , this.message});

  Register.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json["message"];
    data = json['data'] != null ? RegisterData?.fromJson(json['data']) : null;
  }
}

class RegisterData {
  int? id;
  String? name;
  String? iqama;
  String? phone;
  String? email;
  String? token;

  RegisterData(
      {this.id,
      this.name,
      this.iqama,
      this.phone,
      this.token});

  RegisterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iqama = json['iqama'];
    phone = json['phone'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iqama'] = iqama;
    data['phone'] = phone;
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}
