import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/home/controllers/home_controller.dart';
 import 'package:musaneda/components/hourly/return_back_btn.dart';

import '../../../../../components/myInkWell.dart';
import '../../../../../components/myMusaneda.dart';
import '../../../../../components/myServices.dart';
import '../../../../../config/myColor.dart';
import '../../../../routes/app_pages.dart';

class HomeServices extends GetView<HomeController> {
  const HomeServices({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getMusaneda();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'service_request'.tr,
            style: TextStyle(
              color: MYColor.buttons,
            ),
          ),
          leading: ReturnButton(color: MYColor.primary, size: 20.0),
        ),
        body: GetX(
          init: HomeController.I,
          builder: (ctx) {
            return ListView(
              children: [
                controller.isLoadingSliders.value == true
                    ? SizedBox(
                        height: 200.0,
                        width: Get.width,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: MYColor.primary,
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.asset(
                          'assets/images/png/slider_1.png',
                          height: 190,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    'services_include'.tr,
                    style: TextStyle(
                      color: MYColor.primary,
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const MyServices(left: 20, right: 20),
                const SizedBox(height: 5),
                const Divider(thickness: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "best_services".tr,
                            style: TextStyle(
                              color: MYColor.primary,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          myInkWell(
                            fun: () {
                               //Get.to(() => const ServicesView());
                            },
                            text: "see_all".tr,
                            size: 14,
                            font: 'cairo_regular',
                            color: MYColor.greyDeep,
                          ),
                        ],
                      ),
                      // const SizedBox(height: 5),
                      Column(
                        children: [
                          controller.isLoadingSliders.value == true
                              ? const SizedBox.shrink()
                              : SizedBox(
                                  height: Get.height / 2.6,
                                  child: LazyLoadScrollView(
                                    onEndOfPage: () {
                                      HomeController.I.getMoreMusaneda();
                                    },
                                    isLoading: HomeController.I.lastPage.value,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          HomeController.I.listMusaneda.length,
                                      itemBuilder: (context, i) {
                                        final musaneda =
                                            HomeController.I.listMusaneda[i];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5, top: 5),
                                          child: InkWell(
                                            onTap: () {
                                              Get.toNamed(
                                                Routes.MUSANEDA,
                                                arguments: musaneda,
                                              );
                                            },
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: myMusanedaCard(
                                              context: context,
                                              name: LanguageController
                                                          .I.getLocale ==
                                                      "ar"
                                                  ? musaneda.name?.ar!
                                                      .toLowerCase()
                                                  : musaneda.name?.en!
                                                      .toLowerCase(),
                                              image: musaneda.image,
                                              country: LanguageController
                                                          .I.getLocale ==
                                                      "ar"
                                                  ? musaneda
                                                      .nationality?.name?.ar
                                                  : musaneda
                                                      .nationality?.name?.en,
                                              age:
                                                  '${musaneda.age} ${'year'.tr}',
                                              about: LanguageController
                                                          .I.getLocale ==
                                                      "ar"
                                                  ? musaneda.description!.ar
                                                  : musaneda.description!.en,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                          Obx(
                            () => Visibility(
                              visible: HomeController.I.isLoading.value,
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              child: Center(
                                  child: LoadingAnimationWidget.waveDots(
                                      color: MYColor.primary, size: 50.0)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
}
