import 'package:get/get.dart';
import 'package:musaneda/config/constance.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class NotificationProvider extends GetConnect {
  Future<int> updateFCMToken(Map data) async {
    try {
      final res = await post(
        "${Constance.apiEndpoint}/update-fcmToken",
        data,
        headers: {
          'Accept':'application/json',
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );
      return res.statusCode!;
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
