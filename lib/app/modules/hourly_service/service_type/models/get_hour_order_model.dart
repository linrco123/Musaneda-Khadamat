class GetHourOrderModel {
  int? code;
  String? message;
  Data? data;

  GetHourOrderModel({this.code, this.message, this.data});

  GetHourOrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<HourData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <HourData>[];
      json['data'].forEach((v) {
        data!.add(HourData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class HourData {
  int? id;
  String? fromDate;
  String? toDate;
  int? servantCount;
  int? cost;
  int? visits;
  String? userName;
  String? paymentStatus;
  Package? package;
  List<Servants>? servants;

  HourData(
      {this.id,
      this.fromDate,
      this.toDate,
      this.servantCount,
      this.cost,
      this.visits,
      this.userName,
      this.paymentStatus,
      this.package,
      this.servants});

  HourData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    servantCount = json['servant_count'];
    cost = json['cost'];
    visits = json['visits'];
    userName = json['user_name'];
    paymentStatus = json['payment_status'];
    package =
        json['package'] != null ? Package.fromJson(json['package']) : null;
    if (json['servants'] != null) {
      servants = <Servants>[];
      json['servants'].forEach((v) {
        servants!.add(Servants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['servant_count'] = servantCount;
    data['cost'] = cost;
    data['visits'] = visits;
    data['user_name'] = userName;
    data['payment_status'] = paymentStatus;
    if (package != null) {
      data['package'] = package!.toJson();
    }
    if (servants != null) {
      data['servants'] = servants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Package {
  String? title;
  String? shift;
  String? duration;
  int? fromTime;
  int? endTime;

  Package({this.title, this.shift, this.duration, this.fromTime, this.endTime});

  Package.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    shift = json['shift'];
    duration = json['duration'];
    fromTime = json['from_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['shift'] = shift;
    data['duration'] = duration;
    data['from_time'] = fromTime;
    data['end_time'] = endTime;
    return data;
  }
}

class Servants {
  int? id;
  String? name;
  String? fileNo;

  Servants({this.id, this.name, this.fileNo});

  Servants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fileNo = json['file_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['file_no'] = fileNo;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}