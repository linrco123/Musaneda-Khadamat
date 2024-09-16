import 'dart:async';
import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:musaneda/config/constance.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../amazon_model/tabby_model.dart';

class PayWithStcProvider extends GetConnect {
  static PayWithStcProvider get instance => PayWithStcProvider.instance;
  Timer? timer;
  @override
  void onInit() {
    httpClient.baseUrl = Constance.sandenyBaseUrl;
    EasyLoading.addStatusCallback(
      (status) {
        if (status == EasyLoadingStatus.dismiss) {
          timer?.cancel();
        }
      },
    );
  }

  // Pay with Tabby and StcPay
  Future<TabbyModel> payWithStcPay({
    required String transactionId,
    required String type,
    required String urlType,
    required String orderId,
  }) async {
    try{
      await Future.delayed(const Duration(seconds: 1));
      final response = await get(
        "${Constance.apiEndpoint}/amazon-pay",
        headers: {
          "authorization": "Bearer ${Constance.instance.token}",
          "Accept": "application/json",
        },
        query: {
          "type": type,
          "user_package_order_id":orderId,
          "url_type": urlType,
          "transaction_id": transactionId,

        },
      );

      var statusCode = response.statusCode;
      var data = response.body;
      log('this is the signature data: $data');
      log('this is the status code: $statusCode');

      if (statusCode == 401) {
        //userNotRegisteredWidget(Get.context!);
        log('#############@@@@@@@@@@@');
      }

      if (data['code'] == 1) {
        EasyLoading.dismiss();
        return TabbyModel.fromJson(data);
      }

      if (data['code'] == 2) {
        EasyLoading.dismiss();
        //Dialogs.errorDialog(Get.context!, 'unknown_error'.tr);
      }
      return TabbyModel.fromJson(data);
    }catch(e,s){
      log('Error is :::: ${e.toString()}');
      await Sentry.captureException(e,stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
