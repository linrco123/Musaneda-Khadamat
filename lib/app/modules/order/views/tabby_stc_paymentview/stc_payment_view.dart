import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/order/controllers/tabby_stc_controllers/stc_controller.dart';
import 'package:musaneda/config/myColor.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../routes/app_pages.dart';

class STCPaymentView extends GetView<StcPayPaymentController> {
  const STCPaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var isArabic = Get.locale!.languageCode == 'ar';
     final String transactionId = Get.arguments[0] as String;
    final String orderId = Get.arguments[1] as String;
    controller.initWebView(transactionId , orderId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        elevation: 0,
        leading: Padding(
          padding: isArabic
              ? const EdgeInsets.only(right: 30)
              : const EdgeInsets.only(left: 30),
          child: IconButton(
            splashColor: Colors.transparent,
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
            },
            icon: Icon(
              Icons.arrow_back,
              color: MYColor.white,
            ),
          ),
        ),
        title:  Text(
          '${'payment'.tr} ${'via'.tr} STC Pay',
        ),
      ),
      body: WebViewWidget(
        controller: controller.webViewController,
      ),
    );
  }
}
