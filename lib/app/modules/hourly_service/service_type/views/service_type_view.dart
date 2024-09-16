import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/home/controllers/home_controller.dart';
import 'package:musaneda/app/modules/hourly_service/mediation/views/add_mediation_view.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/controllers/servicetype_controller.dart';
import 'package:musaneda/components/hourly/service_type/service_type_card.dart';
import 'package:musaneda/components/myFilterDialog.dart';
import 'package:musaneda/config/myColor.dart';

class ServiceTypeView extends GetView<HomeController> {
  const ServiceTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    var serviceTypeController = Get.put(ServiceTypeController());
    return Scaffold(
      body: GetBuilder<HomeController>(
          init: controller,
          builder: (controller) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              color: MYColor.primary.withOpacity(0.1),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 0.0, top: 10.0),
                      child: Center(
                        child: Image.asset(
                          'assets/images/hamaLogo.png',
                          height: 80.0,
                          width: 150.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'choose_service'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MYColor.primary,
                            fontSize: 18.0),
                      ),
                    ),
                    ServiceTypeCard(
                        title: 'hour_service'.tr,
                        description: 'hour_service_desc'.tr,
                        image: 'assets/images/hours.png',
                        function: () async {
                          serviceTypeController.showAcceptanceDialogue(context);
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ServiceTypeCard(
                        title: 'stayin_service'.tr,
                        description: 'stayin_service_desc'.tr,
                        image: 'assets/images/contract.png',
                        function: () async {
                          // await EasyLoading.show(status: 'loading'.tr);
                         // Get.to(()=>const HomeServices());
                          myFilterDialog(context);
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ServiceTypeCard(
                        title: "mediation_service".tr,
                        description: "mediation_service".tr,
                        function: () {
                          Get.to(()=>const AddMediationView());
                        },
                        svg: true,
                        image: 'assets/images/drawer/delegation.svg')
                  ],
                ),
              ),
            );
          }),
    );
  }
}
