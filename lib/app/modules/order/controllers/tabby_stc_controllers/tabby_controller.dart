import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/order/providers/stc_tabby_provider/tabby_provider.dart';
import 'package:musaneda/components/mySnackbar.dart';
import 'package:musaneda/config/myColor.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../routes/app_pages.dart';
import '../../amazon_model/tabby_model.dart';


class TabbyPaymentController extends GetxController {
  final NetworkInfo _info = NetworkInfo();

  static TabbyPaymentController get instance =>
      Get.put(TabbyPaymentController());

  RxBool isLoading = false.obs;

  RxString tabbySignature = ''.obs;

  TabbyModel getTabbyData = TabbyModel();

  set setTabbyData(TabbyModel data) {
    getTabbyData = data;
    update();
  }

  TabbyModel get getSignatureData => getTabbyData;

  final payWithTabbyProvider = PayWithTabbyProvider();

  late final WebViewController webViewController;

  Future<void> paymentWithTabby(String transactionId , String orderId) async {
  try{
    log('this is the appointmentId in tabby: $transactionId');
    var generatedSignature = await payWithTabbyProvider.payWithTabby(
        transactionId: transactionId, type: 'TABBY', urlType: '0' , orderId: orderId);
    setTabbyData = generatedSignature;
  }catch(e){
      
  }
  }

  void initWebView(String transactionId , String orderId) async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    await paymentWithTabby(transactionId , orderId);

    _loadUrl();
  }

  void _loadUrl() {
    _postFormData();
  }

  void _postFormData() async {
    String formData = getSignatureData.data!;
    await webViewController.loadHtmlString(
      formData,
    );

    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          EasyLoading.show(status: 'loading'.tr);
          if (progress == 100) {
             EasyLoading.dismiss();
          }
        },
        onPageFinished: (url) {
          EasyLoading.dismiss();
          log('this is the url: $url');
          if (url.contains('success')) {
            mySnackBar(
              title: "success".tr,
              message: "payment_success".tr,
              color: MYColor.success,
              icon: CupertinoIcons.info_circle,
            );
            Future.delayed(
              const Duration(seconds: 3),
                  () {
               Get.offAllNamed(Routes.HOME);
              },
            );
          }

          if (url.contains('confirm')) {
            mySnackBar(
              title: "success".tr,
              message: "payment_success".tr,
              color: MYColor.success,
              icon: CupertinoIcons.info_circle,
            );
            Future.delayed(
              const Duration(seconds: 3),
                  () {
                Get.offAllNamed(Routes.HOME);
              },
            );
          }

          if (url.contains('reject')) {
            mySnackBar(
              title: "error".tr,
              message: "payment_failed".tr,
              color: MYColor.warning,
              icon: CupertinoIcons.info_circle,
            );
            Future.delayed(
              const Duration(seconds: 3),
                  () {
                Get.back();

                  },
            );
          }
        },
        onWebResourceError: (error) {
          EasyLoading.dismiss();
          mySnackBar(
            title: "error".tr,
            message: "payment_failed".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
          log('this is the error: $error');
        },
      ),
    );
  }
}