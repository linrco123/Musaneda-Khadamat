import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/config/functions.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../complaints_model.dart';
import 'package:http/http.dart' as http;

class ComplaintsProvider extends GetConnect {
  final box = GetStorage();

  Future<Complaints> getComplaints() async {
    await EasyLoading.show(status: 'waiting'.tr);
    try {
      final res = await http.get(
        Uri.parse("${Constance.apiEndpoint}/complaints"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.getToken()}"
        },
      );
      await EasyLoading.dismiss();
      if (jsonDecode(res.body)['code'] == 0) {}
      if (jsonDecode(res.body)['code'] == 1) {}
      if (res.statusCode != 200) {
        return Future.error(res.statusCode);
      } else {
        return Complaints.fromJson(jsonDecode(res.body));
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  Future<int> postComplaints(formData) async {
    await EasyLoading.show(status: 'loading'.tr);
    try {
      final res = await post(
        "${Constance.apiEndpoint}/create_complaints",
        formData,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.getToken()}"
        },
      );
       print('=========================complaints=========================');
       print(res.body);
      await EasyLoading.dismiss();
      if (res.statusCode == 401) {
        showLoginSignupDialogue(Get.context);
        return Future.error(res.statusCode!);
      }

      if (res.body['code'] == 0) {
        if (res.body['data']['name'] != null) {
          mySnackBar(
            title: "عفوا",
            message: "الرجاء ادخال الاسم",
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['description'] != null) {
          mySnackBar(
            title: "عفوا",
            message: "الرجاء ادخال الوصف",
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['type'] != null) {
          mySnackBar(
            title: "عفوا",
            message: "الرجاء ادخال نوع الشكوى",
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['importance'] != null) {
          mySnackBar(
            title: "عفوا",
            message: "الرجاء ادخال اهمية الشكوى",
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['file'] != null) {
          mySnackBar(
            title: "عفوا",
            message: "الرجاء ادخال الملف",
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['contract_id'] != null) {
          mySnackBar(
            title: "عفوا",
            message: "الرجاء ادخال رقم العقد",
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "msg_ticket_success".tr,
          color: MYColor.success,
          icon: CupertinoIcons.check_mark_circled,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return res.body['code'];
      }
    } catch (e, s) {
      print('error=================================>>>>>>>>>>> $e');
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
