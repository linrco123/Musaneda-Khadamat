import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/components/hourly/return_back_btn.dart';
import 'package:musaneda/components/myServices.dart';

import '../../../../components/myCupertinoButton.dart';
import '../../../../components/myMusaneda.dart';
import '../../../../config/myColor.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class FilterView extends GetView<HomeController> {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: MYColor.primary.withOpacity(0.1),
          elevation: 0.0,
          title: Text(
            'service_request'.tr,
            style: TextStyle(
              color: MYColor.buttons,
            ),
          ),
          centerTitle: true,
          leading: ReturnButton(color: MYColor.primary, size: 20.0),
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark),
        ),
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          //color: MYColor.primary.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Image.asset(
                    'assets/images/png/slider_1.png',
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Text(
                    'services_include'.tr,
                    style: TextStyle(
                      color: MYColor.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const MyServices(left: 10.0, right: 10.0),
                const SizedBox(height: 5),
                 Obx(
                  () {
                    if (controller.listFilter.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/icon/no_result.svg",
                                height: 134.36,
                                width: 100,
                                color: MYColor.primary,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "there_are_no_results".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: MYColor.grey,
                                  fontFamily: 'cairo_regular',
                                ),
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                height: 50,
                                width: 166,
                                child: MyCupertinoButton(
                                  fun: () {
                                    controller.setTap = 1;
                                    Get.back();
                                  },
                                  text: "back_to_home".tr,
                                  btnColor: MYColor.buttons,
                                  txtColor: MYColor.btnTxtColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: controller.isLoading.value
                          ? Center(
                              child: LoadingAnimationWidget.waveDots(
                                  color: MYColor.primary, size: 50.0),
                            )
                          : LazyLoadScrollView(
                              onEndOfPage: () {
                                HomeController.I.getMoreFilter();
                              },
                              isLoading: HomeController.I.lastPage.value,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: controller.listFilter.length,
                                itemBuilder: (context, i) {
                                  final musaneda = controller.listFilter[i];
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.MUSANEDA,
                                          arguments: musaneda,
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: myMusanedaCard(
                                        context: context,
                                        name: LanguageController.I.getLocale ==
                                                'ar'
                                            ? musaneda.name?.ar
                                            : musaneda.name?.en,
                                        image: musaneda.image,
                                        country: LanguageController
                                                    .I.getLocale ==
                                                'ar'
                                            ? musaneda.nationality?.name?.ar
                                            : musaneda.nationality?.name?.en,
                                        age: "${musaneda.age} ${"year".tr}",
                                        about: LanguageController.I.getLocale ==
                                                'ar'
                                            ? musaneda.description?.ar
                                            : musaneda.description?.en,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
