
class HourOrderModel {
    String? msg;
    Data? data;
    int? code;

    HourOrderModel({this.msg, this.data, this.code});

    HourOrderModel.fromJson(Map<String, dynamic> json) {
        msg = json["msg"];
        data = json["data"] == null ? null : Data.fromJson(json["data"]);
        code = json["code"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["msg"] = msg;
        if(data != null) {
          //  data["data"] = data?.toJson();
        }
        data["code"] = code;
        return data;
    }
}

class Data {
    Order? order;

    Data({this.order});

    Data.fromJson(Map<String, dynamic> json) {
        order = json["order"] == null ? null : Order.fromJson(json["order"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        if(order != null) {
            data["order"] = order?.toJson();
        }
        return data;
    }
}

class Order {
    String? countryId;
    String? duration;
    String? shift;
    String? fromDate;
    String? visits;
    String? toDate;
    String? fromTime;
    String? servantCount;
    String? userAddressId;
    int? cost;
    int? userId;
    String? updatedAt;
    String? createdAt;
    int? id;

    Order({this.countryId, this.duration, this.shift, this.fromDate, this.visits, this.toDate, this.fromTime, this.servantCount, this.userAddressId, this.cost, this.userId, this.updatedAt, this.createdAt, this.id});

    Order.fromJson(Map<String, dynamic> json) {
        countryId = json["country_id"];
        duration = json["duration"];
        shift = json["shift"];
        fromDate = json["from_date"];
        visits = json["visits"];
        toDate = json["to_date"];
        fromTime = json["from_time"];
        servantCount = json["servant_count"];
        userAddressId = json["user_address_id"];
        cost = json["cost"];
        userId = json["user_id"];
        updatedAt = json["updated_at"];
        createdAt = json["created_at"];
        id = json["id"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["country_id"] = countryId;
        data["duration"] = duration;
        data["shift"] = shift;
        data["from_date"] = fromDate;
        data["visits"] = visits;
        data["to_date"] = toDate;
        data["from_time"] = fromTime;
        data["servant_count"] = servantCount;
        data["user_address_id"] = userAddressId;
        data["cost"] = cost;
        data["user_id"] = userId;
        data["updated_at"] = updatedAt;
        data["created_at"] = createdAt;
        data["id"] = id;
        return data;
    }
}