import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/home/controllers/home_controller.dart';
import 'package:musaneda/components/hourly/return_back_btn.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsConditionsWebview extends GetView<HomeController> {
  const TermsConditionsWebview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              WebViewWidget(controller: controller.webViewController),
              const Positioned(
                top: 2.0,
                right: 10,
                child: CircledBackButton()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
