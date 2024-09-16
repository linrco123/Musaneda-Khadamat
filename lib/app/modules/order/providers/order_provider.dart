import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/order/order_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../single_bill_model.dart';

class OrderProvider extends GetConnect {
  Future<OrderModel> postOrder(Map data) async {
    try {
      await EasyLoading.show(status: 'loading'.tr);
      final res = await post(
        "${Constance.apiEndpoint}/contracts",
        data,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.getToken()}",
        },
      );
        
      if (res.body['code'] == 0) {
        await EasyLoading.dismiss();
        if (res.body['message'] == 'sorry you have an order') {
          mySnackBar(
            title: "warning".tr,
            message: "you_have_unexpired_contract".tr,
            color: MYColor.sadad,
            icon: CupertinoIcons.info_circle,
          );
        }
        return Future.error(res.status);

        //return OrderModel(code: 1,data: null,msg: '');
      }
      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "msg_order_success".tr,
          color: MYColor.success,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return OrderModel.fromJson(res.body);
      }
    } catch (e, s) {
      await EasyLoading.dismiss();
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  //pay_in_branch
  Future<int> payInBranch(Map data) async {
    try {
      await EasyLoading.show(status: 'loading'.tr);
      final res = await post(
        "${Constance.apiEndpoint}/pay-in-branch",
        data,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.getToken()}",
        },
      );
        
      if (res.body['code'] == 0) {
        await EasyLoading.dismiss();
        mySnackBar(
          title: "error".tr,
          message: "try again",
          color: MYColor.success,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.body['code'] == 1) {
        await EasyLoading.dismiss();
        mySnackBar(
          title: "success".tr,
          message: "order has been confirmed",
          color: MYColor.success,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status); //res.body['code']
      } else {
        return res.body['code'];
      }
    } catch (e, s) {
      await EasyLoading.dismiss();
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Create Single Bill
  Future<SingleBill> createSingleBill(Map data) async {
    try {
      final res = await post(
        "${Constance.apiEndpoint}/create-single-bill",
        data,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      log(res.body.toString(), name: "create_single_bill");

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "sorry_you_have_existed_order".tr,
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.body['Status']['Code'] == 0 &&
          res.body['Description'] == "Success") {
        mySnackBar(
          title: "success".tr,
          message: "payment_success".tr,
          color: MYColor.success,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.body['Status']['Code'] != 0) {
        mySnackBar(
          title: "error".tr,
          message: "payment_failed".tr,
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return SingleBill.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
