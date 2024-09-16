import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/internet_conn_status/controllers/internet_conn_controller.dart';
import 'package:musaneda/components/myCupertinoButton.dart';
import 'package:musaneda/config/myColor.dart';

class InternetConnectionView extends GetView<InternetConnectionController> {
  const InternetConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: MYColor.primary.withOpacity(0.1),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark),
      ),
      body: GetBuilder<InternetConnectionController>(
        init: controller,
        builder: (controller) {
          return Container(
            height: Get.height,
            width: Get.width,
            color: MYColor.primary.withOpacity(0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/wifi1.png',
                  height: 100.0,
                  width: 100.0,
                  color: MYColor.primary,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  'no_internet_conn'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: MYColor.grey),
                ),
                Text(
                  'steps_back_conn'.tr,
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: MYColor.grey),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.check_mark_circled_solid,
                      size: 20.0,
                      color: MYColor.black.withOpacity(0.6),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "check_modem".tr,
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: MYColor.grey),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.check_mark_circled_solid,
                      size: 20.0,
                      color: MYColor.black.withOpacity(0.6),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "check_wifi".tr,
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: MYColor.grey),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: 150.0,
                  height: 50.0,
                  child: MyCupertinoButton(
                      fun: () {
                        controller.checkConnectivityToInternet();
                      },
                      text: 'reload',
                      btnColor: MYColor.buttons,
                      txtColor: MYColor.btnTxtColor),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
