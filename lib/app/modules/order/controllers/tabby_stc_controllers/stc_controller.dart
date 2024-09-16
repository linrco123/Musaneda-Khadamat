import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../components/mySnackbar.dart';
import '../../../../../config/myColor.dart';
import '../../../../routes/app_pages.dart';
import '../../amazon_model/tabby_model.dart';
import '../../providers/stc_tabby_provider/stc_provider.dart';


class StcPayPaymentController extends GetxController {
  final NetworkInfo _info = NetworkInfo();

  static StcPayPaymentController get instance =>
      Get.put(StcPayPaymentController());

  RxBool isLoading = false.obs;

  RxString tabbySignature = ''.obs;

  TabbyModel payWithTabbyModel = TabbyModel();

  set setPayWithTabbyData(TabbyModel data) {
    payWithTabbyModel = data;
    update();
  }

 TabbyModel get getPayWithTabbyData => payWithTabbyModel;

  final payWithStcProvider = PayWithStcProvider();

  late final WebViewController webViewController;

  Future<void> paymentWithStcPay(String transactionId , String orderId) async {
    var generatedSignature = await payWithStcProvider.payWithStcPay(
      transactionId: transactionId,
      type: 'STCPAY',
      urlType: '0',
      orderId:orderId
    );
    setPayWithTabbyData = generatedSignature;
  }

  void initWebView(String transactionId , String orderId) async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    await paymentWithStcPay(transactionId , orderId);
    _loadUrl();
  }

  void _loadUrl() {
    _postFormData();
  }

  void _postFormData() async {
    String formData = getPayWithTabbyData.data!;
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
          if (url.contains('success')) {
            mySnackBar(
              title: "success".tr,
              message: "payment_success".tr,
              color: MYColor.success,
              icon: CupertinoIcons.info_circle,
            );

            Future.delayed(
              const Duration(seconds: 4),
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
              const Duration(seconds: 4),
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
              const Duration(seconds: 4),
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