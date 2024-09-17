class FirebaseMessageModel {
  String? msg;
  Data? data;
  int? code;

  FirebaseMessageModel({this.msg, this.data, this.code});

  FirebaseMessageModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data']['notifications'] != [] ? new Data.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
  List<Notifications>? notifications;
  Pagination? pagination;

  Data({this.notifications, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Notifications {
  String? id;
  String? type;
  int? servantId;
  NotificationData? data;
  String? readAt;

  Notifications({this.id, this.type, this.servantId, this.data, this.readAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    servantId = json['servant_id'];
    data = json['data'] != null ? new NotificationData.fromJson(json['data']) : null;
    readAt = json['read_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['servant_id'] = this.servantId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['read_at'] = this.readAt;
    return data;
  }
}

class NotificationData {
  String? title;
  String? message;

  NotificationData({this.title, this.message});

  NotificationData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['message'] = this.message;
    return data;
  }
}

class Pagination {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  String? nextPageUrl;
  String? prevPageUrl;

  Pagination(
      {this.total,
      this.perPage,
      this.currentPage,
      this.lastPage,
      this.nextPageUrl,
      this.prevPageUrl});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['next_page_url'] = this.nextPageUrl;
    data['prev_page_url'] = this.prevPageUrl;
    return data;
  }
}