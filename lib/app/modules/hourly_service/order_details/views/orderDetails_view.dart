import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/hourly_service/date_picker/controllers/date_picker_controller.dart';
import 'package:musaneda/app/modules/hourly_service/order_details/controllers/orderdetails_controller.dart';
import 'package:musaneda/app/modules/hourly_service/packages/controllers/packages_controller.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/controllers/servicetype_controller.dart';
import 'package:musaneda/app/modules/locations/controllers/locations_controller.dart';
import 'package:musaneda/app/modules/locations/locations_model.dart';
import 'package:musaneda/components/hourly/packages/package_card.dart';
import 'package:musaneda/components/hourly/return_back_btn.dart';
import 'package:musaneda/components/myCupertinoButton.dart';
import 'package:musaneda/config/myColor.dart';

class OrderDetailsView extends GetView<LocationsController> {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var packageController = Get.find<PackagesController>();
    var datePickerController = Get.find<DatePickerController>();
    var serviceTypeController = Get.find<ServiceTypeController>();
    var locationController = Get.find<LocationsController>();
    var orderDetailsController = Get.put(OrderdetailsController());
    return Scaffold(
      backgroundColor: MYColor.primary.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: MYColor.primary.withOpacity(0.1),
        title: Text(
          "order_details".tr,
          style: TextStyle(color: MYColor.primary),
        ),
        leading: ReturnButton(color: MYColor.primary, size: 20.0),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        height: Get.height,
        width: Get.width,
        color: MYColor.primary.withOpacity(0.1),
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
              height: 20.0,
            ),
            GetX(
                init: controller,
                builder: (controller) {
                  if (controller.isLoading.value) {
                    return const SizedBox();
                  } else {
                    LocationsData chosenLocation =
                        locationController.listLocations.firstWhere(
                            (location) =>
                                location.id ==
                                serviceTypeController.selectedLocation.value,
                            orElse: () => locationController.listLocations[0]);
                    return Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            width: Get.width,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: MYColor.primary.withOpacity(0.2),
                                      blurRadius: 5.0,
                                      offset: const Offset(1, 1))
                                ],
                                border: Border.all(
                                    color: MYColor.primary, width: 2.0),
                                borderRadius: BorderRadius.circular(5.0),
                                color: MYColor.white),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'total_price'.tr,
                                      style: TextStyle(
                                          color: MYColor.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                    VerticalDivider(
                                      color: MYColor.primary,
                                      thickness: 5.0,
                                      width: 5.0,
                                      indent: 1.0,
                                      endIndent: 5.0,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          serviceTypeController.totalPackageCost
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: MYColor.primary),
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Text('sar'.tr,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: MYColor.primary,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          MyPackageCard(
                              package: packageController.hourPackages
                                  .firstWhere((package) =>
                                      package.id ==
                                      packageController.selectedPackage.value),
                              isActive: false),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            //height: 80.0,
                            width: Get.width,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: MYColor.primary.withOpacity(0.2),
                                      blurRadius: 5.0,
                                      offset: const Offset(1, 1))
                                ],
                                borderRadius: BorderRadius.circular(5.0),
                                color: MYColor.white),
                            child: Column(
                              children: [
                                Text(
                                  'date'.tr,
                                  style: TextStyle(
                                      color: MYColor.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  datePickerController.selectedDate.value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MYColor.primary,
                                      fontSize: 15.0),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'address'.tr,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: MYColor.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(chosenLocation.address!,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: MYColor.primary)),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        '${'building_number'.tr}: ${chosenLocation.buildingNumber} , ${'floor_number'.tr}: ${chosenLocation.floorNumber}',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: MYColor.primary),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            //height: 80.0,
                            width: Get.width,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: MYColor.primary.withOpacity(0.2),
                                      blurRadius: 5.0,
                                      offset: const Offset(1, 1))
                                ],
                                borderRadius: BorderRadius.circular(5.0),
                                color: MYColor.white),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'nationality'.tr,
                                      style: TextStyle(
                                          color: MYColor.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                    VerticalDivider(
                                      color: MYColor.primary,
                                      thickness: 5.0,
                                      width: 5.0,
                                      indent: 1.0,
                                      endIndent: 5.0,
                                    ),
                                    Text(
                                      LanguageController.I.isEnglish
                                          ? serviceTypeController
                                              .nationalityList
                                              .firstWhere((nationality) =>
                                                  nationality.id ==
                                                  serviceTypeController
                                                      .nationality.value)
                                              .name!
                                              .en!
                                          : serviceTypeController
                                              .nationalityList
                                              .firstWhere((nationality) =>
                                                  nationality.id ==
                                                  serviceTypeController
                                                      .nationality.value)
                                              .name!
                                              .ar!,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: MYColor.primary),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'visits_number'.tr,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: MYColor.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        LanguageController.I.isEnglish
                                            ? serviceTypeController
                                                .visitNumberList
                                                .firstWhere((visit) =>
                                                    visit.id ==
                                                    serviceTypeController
                                                        .visitsNumber.value)
                                                .name!
                                                .en!
                                            : serviceTypeController
                                                .visitNumberList
                                                .firstWhere((visit) =>
                                                    visit.id ==
                                                    serviceTypeController
                                                        .visitsNumber.value)
                                                .name!
                                                .ar!,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: MYColor.primary)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('maids_number'.tr,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: MYColor.black,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        serviceTypeController.maidsNumber.value
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: MYColor.primary))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const SizedBox(height: 5.0),
                          SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: MyCupertinoButton(
                                fun: () {
                                  orderDetailsController.payViaMada(context,
                                      date: datePickerController
                                          .selectedDate.value,
                                      package: packageController
                                          .selectedPackage.value,
                                      paymentOption: 4);
                                },
                                text: 'btn_title_mada'.tr,
                                btnColor: MYColor.buttons,
                                txtColor: MYColor.btnTxtColor),
                          ),
                          const SizedBox(height: 5.0),
                          locationController.city.value.contains('الرياض') ||
                                  locationController.city.value
                                      .contains('Riyadh')
                              ? SizedBox(
                                  width: double.infinity,
                                  height: 50.0,
                                  child: MyCupertinoButton(
                                      fun: () {
                                        // const PAYMENT_WAY = [
                                        //  1 => 'CASH',
                                        //  2 => 'Online',
                                        //  3 => 'Bank transfer',
                                        //  4 => 'MADA',
                                        //      ];
                                        serviceTypeController.submitHourlyOrder(
                                            context,
                                            datePickerController
                                                .selectedDate.value,
                                            packageController
                                                .selectedPackage.value,
                                            3);
                                      },
                                      text: 'btn_title_bank_transfer'.tr,
                                      btnColor: MYColor.buttons,
                                      txtColor: MYColor.btnTxtColor),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(height: 5.0),
                          // SizedBox(
                          //   width: double.infinity,
                          //   height: 50.0,
                          //   child: MyCupertinoButton(
                          //       fun: () {
                          //         // const PAYMENT_WAY = [
                          //         //  1 => 'CASH',
                          //         //  2 => 'Online',
                          //         //  3 => 'Bank transfer',
                          //         //  4 => 'MADA',
                          //         //      ];
                          //         serviceTypeController.submitHourlyOrder(
                          //             datePickerController.selectedDate.value,
                          //             packageController.selectedPackage.value,
                          //             2);
                          //       },
                          //       text: 'btn_title_online'.tr,
                          //       btnColor: MYColor.buttons,
                          //       txtColor: MYColor.btnTxtColor),
                          // ),
                        ],
                      ),
                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
