import 'dart:convert';

import 'package:get/get.dart';
import 'package:musaneda/app/modules/notification/notification_model.dart';
import 'package:musaneda/config/constance.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:http/http.dart' as http;

class NotificationProvider extends GetConnect {
  Future<int> updateFCMToken(Map data) async {
    try {
      final res = await post(
        "${Constance.apiEndpoint}/update-fcmToken",
        data,
        headers: {
          'Accept': 'application/json',
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );
      return res.statusCode!;
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  Future<FirebaseMessageModel> getNotifications(int number) async {
    try {
      final res = await http.get(
        Uri.parse("${Constance.domain}/api/api/notification?page=$number"),
        headers: {
           "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );
      final response = jsonDecode(res.body);
      if (response['code'] == 0) {}

      if (res.statusCode != 200) {
        return Future.error(res.statusCode);
      } else {
        return FirebaseMessageModel.fromJson(response);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
