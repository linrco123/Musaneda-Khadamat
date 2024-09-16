import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';

class ForgotProvider extends GetConnect {
  Future<int> forgotPassword(Map data) async {
    await EasyLoading.show(status: 'create'.tr);
    try {
      final res = await post("${Constance.apiEndpoint}/forgot_password", data);

      log(res.body.toString(), name: 'forgot password');
       
       
      await EasyLoading.dismiss();
      if (res.body['code'] == 0) {
        // Phone number already exists!
        mySnackBar(
          title: "error".tr,
          message: 'try_again'.tr,
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "msg_otp_sent_success".tr,
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
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  Future<int> resetPassword(Map data) async {
    await EasyLoading.show(status: 'create'.tr);
    try {
      final res = await post("${Constance.apiEndpoint}/reset_password", data);
      log(res.body.toString(), name: 'reset password');

      await EasyLoading.dismiss();

      if (res.body['code'] == 0) {
           mySnackBar(
            title: "error".tr,
            message: "try_again".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "msg_reset_password".tr,
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
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  Future<int> sendCode(Map data) async {
    await EasyLoading.show(status: 'create'.tr);
    try {
      final res = await post("${Constance.apiEndpoint}/send_otp", data);
      log(res.body.toString(), name: 'send code');

      await EasyLoading.dismiss();

      if (res.body['code'] == 0) {
        if (res.body['data']['phone'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "try_again".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "enter_the_code_sent_to".tr,
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
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  Future<int> postVerify(Map data) async {
    await EasyLoading.show(status: 'verify'.tr);
    try {
      final res = await post("${Constance.apiEndpoint}/verify_otp", data);
      log(res.body.toString(), name: 'verify code');

      await EasyLoading.dismiss();

      if (res.body['code'] == 0) {
        // Verification code is invalid
        if (res.body['data']['code'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_verification_code_is_invalid".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "msg_verification_success".tr,
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
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
