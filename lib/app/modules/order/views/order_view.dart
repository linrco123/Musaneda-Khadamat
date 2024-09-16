// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/order/views/tabby_stc_paymentview/components/tabby_method.dart';

import 'package:musaneda/app/modules/profile/controllers/profile_controller.dart';
import 'package:musaneda/components/hourly/return_back_btn.dart';
import 'package:musaneda/components/myCupertinoButton.dart';
import 'package:musaneda/components/myStepper.dart';
import 'package:musaneda/components/payment_bank_direct.dart';
import 'package:musaneda/components/payment_branch.dart';
import 'package:musaneda/config/myColor.dart';
import '../../../../components/myDropdown.dart';
import '../../custom_payment/controllers/custom_payment_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/musaneda_model.dart';
import '../../locations/views/create_location_view.dart';
import '../controllers/amazonpayment_controller.dart';
import '../controllers/order_controller.dart';
import 'bank_account/bank_accounts_details_view.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final amazonController = Get.put(() => AmazonPayController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.transparent,
        iconTheme: IconThemeData(color: MYColor.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          'service_request'.tr,
          style: TextStyle(
            color: MYColor.buttons,
          ),
        ),
        centerTitle: true,
        leading: ReturnButton(color: MYColor.buttons, size: 20.0),
      ),
      body: GetBuilder(
        init: controller,
        builder: (ctx) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: MyStepper(
                  child: const ['1', '2', '3', '4'],
                  titles: [
                    "your_data".tr,
                    "package".tr,
                    "summary".tr,
                    "payment".tr
                  ],
                  width: MediaQuery.of(context).size.width,
                  curStep: controller.currentStep.value,
                  color: MYColor.buttons,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
                child: _buildStepperBody(context),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: MYColor.background,
          boxShadow: [
            BoxShadow(
              color: MYColor.buttons.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 10),
        child: GetBuilder(
          init: controller,
          builder: (ctx) {
            return FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myPreviousButton(context),
                    controller.selectedPayment.value == 1
                        ? const SizedBox()
                        : controller.selectedPayment.value == 2
                            ? Platform.isIOS
                                ? myApplePayButton(context)
                                : const SizedBox()
                            : controller.selectedPayment.value == 3
                                ? mySadadButton(context)
                                : myConfirmButton(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStepperBody(BuildContext context) {
    switch (controller.currentStep.value) {
      case 1:
        return myPersonalData(context);
      case 2:
        return myPackage(context);
      case 3:
        return mySummary(context);
      case 4:
        return myPayment(context);
      default:
        return Container();
    }
  }

  Widget myPersonalData(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: SingleChildScrollView(
        child: Column(
          key: ValueKey<int>(controller.currentStep.value),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'city'.tr,
                style: TextStyle(
                  color: MYColor.buttons,
                  fontSize: 14,
                  fontFamily: 'cairo_regular',
                ),
              ),
            ),
            Obx(
              () => myDropdown(
                context: context,
                value: controller.selectedCity.value,
                onChanged: (value) {
                   controller.setCity = value;
                  //controller.selectedCity.value = 1;
                },
                items: HomeController.I.listCities.map(
                  (item) {
                    return DropdownMenuItem(
                      value: item.id,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          LanguageController.I.getLocale == 'en'
                              ? "${item.name?.en}"
                              : "${item.name?.ar}",
                          style: TextStyle(
                            color: MYColor.greyDeep,
                            fontSize: 12,
                            fontFamily: 'cairo_regular',
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'location'.tr,
                style: TextStyle(
                  color: MYColor.buttons,
                  fontSize: 14,
                  fontFamily: 'cairo_regular',
                ),
              ),
            ),
            Obx(
              () => myDropdown(
                context: context,
                value: controller.selectedLocation.value,
                onChanged: (value) {
                  if (value == 0) {
                    Get.to(
                      () => const CreateLocationView(
                        action: 'create',
                        page: 'order',
                      ),
                    );
                  }
                  controller.setLocation = value;
                },
                items: controller.listLocations.map(
                  (item) {
                    return DropdownMenuItem(
                      value: item.id,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          item.title!,
                          style: TextStyle(
                            color: MYColor.greyDeep,
                            fontSize: 12,
                            fontFamily: 'cairo_regular',
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'pick_up_branch'.tr,
                style: TextStyle(
                  color: MYColor.buttons,
                  fontSize: 14,
                  fontFamily: 'cairo_regular',
                ),
              ),
            ),
            Obx(() {
              return myDropdown(
                context: context,
                value: controller.selectedBranch.value,
                onChanged: (value) {
                  controller.setBranch = value;
                },
                items: controller.listBranches.map((item) {
                  return DropdownMenuItem(
                    value: item.id,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        LanguageController.I.getLocale == 'en'
                            ? "${item.name?.en}"
                            : "${item.name?.ar}",
                        style: TextStyle(
                          color: MYColor.greyDeep,
                          fontSize: 12,
                          fontFamily: 'cairo_regular',
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget myPackage(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Stack(
        key: ValueKey<int>(controller.currentStep.value),
        children: [
          Text(
            "choose_your_package".tr,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'cairo_medium',
              color: MYColor.buttons,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: GetBuilder(
              init: controller,
              builder: (ctx) {
                if (controller.listPackages.isEmpty) {
                  return Center(
                    child: Text("the_packages_is_empty".tr),
                  );
                }
                return ListView.builder(
                  itemCount: controller.listPackages.length,
                  itemBuilder: (ctx, i) {
                    var package = controller.listPackages[i];

                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () {
                          controller.setPackage = package;
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 138,
                          width: double.infinity,
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
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 5,
                                  right: 5,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "${LanguageController.I.getLocale == "en" ? package.name!.en : package.name!.ar}",
                                        style: TextStyle(
                                          color: MYColor.black,
                                          fontSize: 14,
                                          fontFamily: 'cairo_regular',
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      // width: 80,
                                      height: 29,
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: MYColor.success.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${'discount'.tr} ${package.discount} ",
                                          style: TextStyle(
                                            color: MYColor.success,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    controller.selectedPackage.value ==
                                            package.id
                                        ? Container(
                                            height: 30.0,
                                            width: 30.0,
                                            decoration: BoxDecoration(
                                                color: MYColor.btnTxtColor1
                                                    .withOpacity(0.3),
                                                shape: BoxShape.circle),
                                            child: Image.asset(
                                              'assets/images/check1.png',
                                              height: 30.0,
                                              width: 30.0,
                                            ),
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/icon/uncheck.svg",
                                            width: 30,
                                            height: 30,
                                          )
                                  ],
                                ),
                              ),
                              Divider(
                                color: MYColor.buttons,
                                thickness: 0.1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "duration".tr,
                                          style: TextStyle(
                                            color: MYColor.black,
                                            fontSize: 12,
                                            fontFamily: 'cairo_regular',
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "${package.duration} ${'month'.tr}",
                                          style: TextStyle(
                                            color: MYColor.buttons,
                                            fontSize: 14,
                                            fontFamily: 'cairo_regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "price".tr,
                                          style: TextStyle(
                                            color: MYColor.black,
                                            fontSize: 12,
                                            fontFamily: 'cairo_regular',
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "${package.price} ${'sar'.tr}",
                                          style: TextStyle(
                                            color: MYColor.buttons,
                                            fontSize: 14,
                                            fontFamily: 'cairo_regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "tax".tr,
                                          style: TextStyle(
                                            color: MYColor.black,
                                            fontSize: 12,
                                            fontFamily: 'cairo_regular',
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "${package.tax} ${'sar'.tr}",
                                          style: TextStyle(
                                            color: MYColor.buttons,
                                            fontSize: 14,
                                            fontFamily: 'cairo_regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget mySummary(BuildContext context) {
    MusanedaData musanedaData = Get.arguments;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Stack(
        key: ValueKey<int>(controller.currentStep.value),
        children: [
          InkWell(
            onTap: () {
              // controller.payWithSadad(context: context, musanedaID: 1);
            },
            child: Text(
              "summary".tr,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'cairo_medium',
                color: MYColor.buttons,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 138,
                    width: double.infinity,
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
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "musaneda_details".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 14,
                                  fontFamily: 'cairo_regular',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: MYColor.buttons,
                          thickness: 0.1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "full_name".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'cairo_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    LanguageController.I.getLocale == 'en'
                                        ? "${musanedaData.name!.en}".length > 15
                                            ? "${"${musanedaData.name!.en}".substring(0, 15)}..."
                                            : "${musanedaData.name!.en}"
                                        : "${musanedaData.name!.ar}".length > 15
                                            ? "${"${musanedaData.name!.ar}".substring(0, 15)}..."
                                            : "${musanedaData.name!.ar}",
                                    style: TextStyle(
                                      color: MYColor.buttons,
                                      fontSize: 14,
                                      fontFamily: 'cairo_regular',
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "education".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'cairo_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    LanguageController.I.getLocale == 'en'
                                        ? "${musanedaData.education!.name!.ar}"
                                        : "${musanedaData.education!.name!.ar}",
                                    style: TextStyle(
                                      color: MYColor.buttons,
                                      fontSize: 14,
                                      fontFamily: 'cairo_regular',
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "nationality".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'cairo_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    LanguageController.I.getLocale == 'en'
                                        ? "${musanedaData.nationality!.name!.en}"
                                        : "${musanedaData.nationality!.name!.ar}",
                                    style: TextStyle(
                                      color: MYColor.buttons,
                                      fontSize: 14,
                                      fontFamily: 'cairo_regular',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 138,
                    width: double.infinity,
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
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "client_details".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 14,
                                  fontFamily: 'cairo_regular',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: MYColor.buttons,
                          thickness: 0.1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: GetBuilder(
                            init: ProfileController.I,
                            builder: (ctx) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                  Text(
                                      "full_name".tr,
                                      style: TextStyle(
                                        color: MYColor.black,
                                        fontSize: 12,
                                        fontFamily: 'cairo_regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${ProfileController.I.profile.name}"
                                                  .length >
                                              15
                                          ? "${"${ProfileController.I.profile.name}".substring(0, 15)}..."
                                          : "${ProfileController.I.profile.name}",
                                      style: TextStyle(
                                        color: MYColor.buttons,
                                        fontSize: 14,
                                        fontFamily: 'cairo_regular',
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "phone_number".tr,
                                      style: TextStyle(
                                        color: MYColor.black,
                                        fontSize: 12,
                                        fontFamily: 'cairo_regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${ProfileController.I.profile.phone}",
                                      style: TextStyle(
                                        color: MYColor.buttons,
                                        fontSize: 14,
                                        fontFamily: 'cairo_regular',
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "duration".tr,
                                      style: TextStyle(
                                        color: MYColor.black,
                                        fontSize: 12,
                                        fontFamily: 'cairo_regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${controller.packagesData.duration} ${"month".tr}",
                                      style: TextStyle(
                                        color: MYColor.buttons,
                                        fontSize: 14,
                                        fontFamily: 'cairo_regular',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 138,
                    width: double.infinity,
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
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "price_details".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 14,
                                  fontFamily: 'cairo_regular',
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 72,
                                height: 29,
                                decoration: BoxDecoration(
                                  color: MYColor.success.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    "${controller.packagesData.total} ${"sar".tr}",
                                    style: TextStyle(
                                      color: MYColor.success,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: MYColor.buttons,
                          thickness: 0.1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "cost".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'cairo_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${controller.packagesData.price} ${"sar".tr}",
                                    style: TextStyle(
                                      color: MYColor.buttons,
                                      fontSize: 14,
                                      fontFamily: 'cairo_regular',
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "discount".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'cairo_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${controller.packagesData.discount} ${"sar".tr}",
                                    style: TextStyle(
                                      color: MYColor.buttons,
                                      fontSize: 14,
                                      fontFamily: 'cairo_regular',
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "tax".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'cairo_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${controller.packagesData.tax} ${"sar".tr}",
                                    style: TextStyle(
                                      color: MYColor.buttons,
                                      fontSize: 14,
                                      fontFamily: 'cairo_regular',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget myPayment(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController.I,
      builder: (controller) => ListView(
        children: [
          Container(
            height: 138,
            width: double.infinity,
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
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "total_amount".tr,
                        style: TextStyle(
                          color: MYColor.black,
                          fontSize: 14,
                          fontFamily: 'cairo_regular',
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 72,
                        height: 29,
                        decoration: BoxDecoration(
                          color: MYColor.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "${controller.packagesData.total} ${"sar".tr}",
                            style: TextStyle(
                              color: MYColor.success,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: MYColor.buttons,
                  thickness: 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "cost".tr,
                            style: TextStyle(
                              color: MYColor.black,
                              fontSize: 12,
                              fontFamily: 'cairo_regular',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${controller.packagesData.price} ${"sar".tr}",
                            style: TextStyle(
                              color: MYColor.buttons,
                              fontSize: 14,
                              fontFamily: 'cairo_regular',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "discount".tr,
                            style: TextStyle(
                              color: MYColor.black,
                              fontSize: 12,
                              fontFamily: 'cairo_regular',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${controller.packagesData.discount} ${"sar".tr}",
                            style: TextStyle(
                              color: MYColor.buttons,
                              fontSize: 14,
                              fontFamily: 'cairo_regular',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "tax".tr,
                            style: TextStyle(
                              color: MYColor.black,
                              fontSize: 12,
                              fontFamily: 'cairo_regular',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${controller.packagesData.tax} ${"sar".tr}",
                            style: TextStyle(
                              color: MYColor.buttons,
                              fontSize: 14,
                              fontFamily: 'cairo_regular',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "payment_method".tr,
            style: TextStyle(
              color: MYColor.buttons,
              fontSize: 16,
              fontFamily: 'cairo_medium',
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(
              controller.paymentMethods.length,
              (index) => InkWell(
                    onTap: () {
                      controller.changePaymentMethod(index);
                    },
                    child: index == 2
                        ? Visibility(
                            visible: GetPlatform.isIOS,
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 1.0,
                                      color: controller.paymentMethod.value ==
                                              index
                                          ? MYColor.primary
                                          : MYColor.white)),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    OrderController
                                        .I.paymentMethods[index].image,
                                    height: 30.0,
                                    width: 30.0,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(controller.paymentMethods[index].name)
                                ],
                              ),
                            ))
                        : Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    width: 1.0,
                                    color:
                                        controller.paymentMethod.value == index
                                            ? MYColor.primary
                                            : MYColor.white)),
                            child: Row(
                              children: [
                                index != 3
                                    ? SvgPicture.asset(
                                        OrderController
                                            .I.paymentMethods[index].image,
                                        height: 20.0,
                                        width: 20.0,
                                        color:
                                            index == 0 ? MYColor.primary : null,
                                      )
                                    : Image.asset(
                                        OrderController
                                            .I.paymentMethods[index].image,
                                        height: 30.0,
                                        width: 30.0,
                                      ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  controller.paymentMethods[index].name,
                                  style: const TextStyle(fontSize: 16.0),
                                )
                              ],
                            ),
                          ),
                  )),
          const SizedBox(
            height: 20,
          ),
          tabbyMethod(context, controller.packagesData.total!),
          const SizedBox(height: 20),
          //Pay through branch
          const BankAccountPayment(),
          const SizedBox(height: 15),
          //Pay through branch
          const PaymentBranch(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  myINPUTDecoration({String? hint, dynamic prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      suffixStyle: const TextStyle(
        color: Colors.black,
      ),
      fillColor: MYColor.accent,
      filled: true,
      errorStyle: TextStyle(
        fontSize: 12,
        locale: Get.deviceLocale,
      ),
      hintText: hint,
      // labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
      hintStyle: TextStyle(
        color: MYColor.greyDeep,
        fontSize: 14,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),

      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon is IconData
          ? Icon(
              prefixIcon,
              color: MYColor.buttons,
            )
          : Container(
              padding: const EdgeInsets.all(6),
              width: 10,
              child: Image.asset(prefixIcon),
            ),
    );
  }

  ///My Previous button
  Widget myPreviousButton(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Visibility(
        key: ValueKey<bool>(controller.currentStep.value != 1),
        visible: controller.currentStep.value != 1,
        child: Container(
          height: 50,
          width: 166,
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: MyCupertinoButton(
            fun: () => controller.decrement(),
            text: "previous".tr,
            btnColor: MYColor.accent,
            txtColor: MYColor.black,
          ),
        ),
      ),
    );
  }

  ///My Apple Pay Button
  Widget myApplePayButton(BuildContext context) {
    return Container(
      height: 50,
      width: controller.currentStep.value == 1 ? 166 * 2 : 166,
      decoration: BoxDecoration(
        color: MYColor.accent,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(1),
      child: CupertinoButton(
        onPressed: () => CustomPaymentController.I
            .applePay(controller.packagesData.total, false),
        color: MYColor.black,
        padding: EdgeInsets.zero,
        child: SvgPicture.asset(
          "assets/images/APPLEPAY.svg",
          width: 45,
          height: 25,
          color: MYColor.white,
        ),
      ),
    );
  }

  ///My Sadad Button
  Widget mySadadButton(BuildContext context) {
    return Container(
      height: 50,
      width: controller.currentStep.value == 1 ? 166 * 2 : 166,
      decoration: BoxDecoration(
        color: MYColor.accent,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(1),
      child: CupertinoButton(
        onPressed: () {
          controller.onSadadPay(
            context: context,
            musanedaID: Get.arguments.id,
          );
        },
        color: MYColor.sadad,
        padding: EdgeInsets.zero,
        child: SvgPicture.asset(
          "assets/images/SADAD.svg",
          width: 50,
          height: 30,
          color: MYColor.white,
        ),
      ),
    );
  }

  ///My Next | Confirm Button
  Widget myConfirmButton(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Container(
        key: ValueKey<bool>(controller.currentStep.value != 4),
        height: 50,
        width: controller.currentStep.value == 1 ? 166 * 2 : 166,
        decoration: BoxDecoration(
          color: MYColor.accent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(1),
        child: MyCupertinoButton(
          fun: () {
            if (OrderController.I.paymentBranch.value) {
              //send request to endpoint (pay_in_branch)
              // parameters ===>  order_id =  ; // payment_branch = true or 1;
              //if suceess to confirm goto home
              Get.to(const BankAccountdetails(), arguments: {
                'orderID': OrderController.I.orderID,
                'totalPrice': OrderController.I.packagesData.total!,
                'page': 'order'
              });
 
            } else if (OrderController.I.paymentBank.value) {
              // //send request to endpoint (pay-through-bank) flag option to 1 for ex
              //if success go to BankAccountdetails screen
              Get.to(const BankAccountdetails(), arguments: {
                'orderID': OrderController.I.orderID,
                'totalPrice': OrderController.I.packagesData.total!,
                'page': 'order'
              });
 
            } else if (controller.currentStep.value == 4) {
               //CustomPaymentController.I.payWithAmazon();
                Get.to(const BankAccountdetails(), arguments: {
                'orderID': OrderController.I.orderID,
                'totalPrice': OrderController.I.packagesData.total!,
                'page': 'order'
              });
            
            } else {
              controller.increment();
            }
          },
          text: controller.currentStep.value == 3
              ? "submit".tr
              : controller.currentStep.value != 4
                  ? "next".tr
                  : controller.paymentBranch.value ||
                          controller.paymentBank.value
                      ? "confirm".tr
                      : "pay".tr,
          btnColor: MYColor.buttons,
          txtColor: MYColor.btnTxtColor,
        ),
      ),
    );
  }
}

enum BrandType { Creditcard, Mada, None }
