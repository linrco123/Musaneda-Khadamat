
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/main_home_page/model/fake_package_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/api_response.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../contract_model.dart';

class MainHomePageProvider extends GetConnect {
  Future<Contract> getContractList() async {
    final response = await get(
      '${Constance.apiEndpoint}/fetch_orders',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Constance.getToken()}",
      },
    );

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return Contract.fromJson(response.body);
    }
  }

  Future<FakePackageModel> getFakePackages(String lang) async {
   try{
     final response = await get(
      '${Constance.apiEndpoint}/fake-packages',
      headers: {
        "Accept-Language":lang,
        "Content-Type": "application/json",
       },
    );
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return FakePackageModel.fromJson(response.body);
    }
   }catch(e , s){
    await Sentry.captureException(e,stackTrace: s);
      return Future.error(e);

   }
  }

  Future<ApiResponse> postContractList(Map data, bool showSuccess) async {
    final response = await post(
      '${Constance.apiEndpoint}/create_order',
      data,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Constance.instance.token}",
      },
    );

    if (response.statusCode == 401) {


      return Future.error(response.statusCode!);
    }

    if (response.body['code'] == 0) {
      if (response.body['message'] == 'sorry you have an order') {
        mySnackBar(
          title: "warning".tr,
          message: "you_have_unexpired_contract".tr,
          color: MYColor.sadad,
          icon: CupertinoIcons.info_circle,
        );
      }
    }
    if (response.body['code'] == 1) {
      if (showSuccess) {
        mySnackBar(
          title: "success".tr,
          message: "msg_order_successfully_done".tr,
          color: MYColor.success,
          icon: CupertinoIcons.check_mark_circled,
        );
      }
    }

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return ApiResponse.fromJson(response.body);
    }
  }

  Future<ApiResponse> cancelContractList(id) async {
    final response = await get(
      '${Constance.apiEndpoint}/cancel_order/$id',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Constance.instance.token}",
      },
    );

    if (response.body['code'] == 1) {
      mySnackBar(
        title: 'order_cancelled'.tr,
        message: 'order_cancelled_successfully'.tr,
        color: MYColor.success,
        icon: CupertinoIcons.check_mark_circled,
      );
    }

    if (response.body['code'] == 0) {
      mySnackBar(
        title: 'error'.tr,
        message: 'msg_order_already_cancelled'.tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    }

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return ApiResponse.fromJson(response.body);
    }
  }

  Future<ApiResponse> payOrder(Map data, bool showSuccess) async {
    final response = await post(
      '${Constance.apiEndpoint}/pay_order',
      data,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Constance.instance.token}",
      },
    );

    if (response.body['code'] == 0) {
      mySnackBar(
        title: "error".tr,
        message: "order_unpaid_successfully".tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    }

    if (response.body['code'] == 1) {
      if (showSuccess) {
        mySnackBar(
          title: "success".tr,
          message: "order_paid_successfully".tr,
          color: MYColor.success,
          icon: CupertinoIcons.check_mark_circled,
        );
      }
    }

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return ApiResponse.fromJson(response.body);
    }
  }
}
