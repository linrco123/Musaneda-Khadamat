import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/components/hourly/return_back_btn.dart';
import 'package:musaneda/config/constance.dart';

import '../../../../config/myColor.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        title: Text('notification'.tr),
        centerTitle: true,
        leading: ReturnButton(
          color: MYColor.white,
          size: 20.0,
        ),
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: 40,
                width: Get.width,
                decoration: BoxDecoration(
                  color: MYColor.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: GetBuilder<NotificationController>(
              init: controller,
              builder: (controller) {
                if (controller.notifyList.isEmpty) {
                  return Center(
                    child: Text(
                      'no_notifications'.tr,
                      style: TextStyle(
                          color: Colors.grey.shade300, fontSize: 20.0),
                    ),
                  );
                }

                return Obx(
                  () => LazyLoadScrollView(
                    onEndOfPage: () {
                      controller.getMoreNotifications();
                    },
                    isLoading: controller.lastPage.value,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: controller.notifyList.length,
                      itemBuilder: (context, i) {
                        final notification = controller.notifyList[i];
                        return Container(
                          height: 100,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: MYColor.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      LanguageController.I.isEnglish
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                                      child: Text(
                                         notification.title!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      textAlign: LanguageController.I.isEnglish
                                          ? TextAlign.end:TextAlign.start,
                                      notification.message!.length > 100
                                          ? '${controller.getNotify[i].message!.substring(0, 100)}...'
                                          : controller.getNotify[i].message!,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Obx(
            () => controller.isLoading.value && Constance.getToken().isNotEmpty
                ? Align(
                    alignment: Alignment.topCenter,
                    child: LoadingAnimationWidget.waveDots(
                        color: MYColor.primary, size: 50.0),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
