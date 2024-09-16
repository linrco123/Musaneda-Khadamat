import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/hourly_service/packages/controllers/packages_controller.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/controllers/servicetype_controller.dart';
import 'package:musaneda/components/hourly/packages/package_card.dart';
import 'package:musaneda/components/hourly/return_back_btn.dart';
import 'package:musaneda/config/myColor.dart';

class PackagesView extends GetView<PackagesController> {
  const PackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    var servcieTypeController = Get.put(ServiceTypeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary.withOpacity(0.1),
        title: Text('choose_package'.tr,
            style: TextStyle(
                color: MYColor.primary, fontSize: 20.0, letterSpacing: 2.0)),
        leading: ReturnButton(color: MYColor.primary, size: 20.0),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: MYColor.primary.withOpacity(0.1),
        padding: const EdgeInsets.all(10.0),
        child: GetX<PackagesController>(
          init: controller,
          builder: (controller) => controller.hourPackages.isEmpty
              ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SvgPicture.asset(
                    "assets/images/icon/no_result.svg",
                    height: 134.36,
                    width: 100,
                    color: MYColor.primary,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "the_packages_is_empty".tr,
                    style: TextStyle(color: MYColor.grey, fontSize: 18.0),
                  ),
                ])
              : Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Image.asset(
                      'assets/images/hamaLogo.png',
                      height: 80.0,
                      width: 150.0,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/package.png',
                            height: 25.0,
                            width: 25.0,
                            fit: BoxFit.fill,
                            color: MYColor.primary),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text('choose_package_desc'.tr,
                            style: TextStyle(
                                color: MYColor.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0)),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                        child: ListView.separated(
                      itemCount: controller.hourPackages.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => MyPackageCard(
                            package: controller.hourPackages[index],
                            isActive: controller.selectedPackage.value ==
                                controller.hourPackages[index].id,
                            onTap: () {
                              controller.selectPackage(
                                  controller.hourPackages[index].id!);
                              servcieTypeController.setPackageCost = controller
                                  .hourPackages[index].cost!
                                  .toDouble();
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 15.0,
                      ),
                    ))
                  ],
                ),
        ),
      ),
    );
  }
}
