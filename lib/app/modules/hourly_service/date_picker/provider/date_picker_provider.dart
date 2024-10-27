import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:musaneda/components/mySnackbar.dart';
import 'package:musaneda/config/constance.dart';
import 'package:musaneda/config/myColor.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
 import 'package:http/http.dart' as http;

class DatePickerProvider {
    
  Future<int> validatePackageTiming(int packageId) async {
    try {
      await EasyLoading.show(status: 'loading'.tr);
      final res = await http.get(
          Uri.parse(
              '${Constance.apiEndpoint}/check-package-timing?package_id=$packageId'),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer ${Constance.getToken()}",
          });
      final response = jsonDecode(res.body);
      print('============================check-package-timing?package_id====================================');
      print(response);
      if (response['code'] == 0) {
        
        mySnackBar(
            title: 'warning'.tr,
            message: 'package_strt_time_by_2'.tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info);
      }
      if (response['code'] == 1) {
        //Get.snackbar('success'.tr, 'Get Packages');
      }

      if (res.statusCode != 200) {
        return Future.error(res.statusCode);
      } else {
        return response['code'];
      }
    } catch (e, s) {
      await Sentry.captureException(s);
      return Future.error(e);
    }
  }
}
  
 