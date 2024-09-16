import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/main_home_page/controllers/main_home_page_controller.dart';
import 'package:musaneda/app/modules/order/controllers/order_controller.dart';
import 'package:musaneda/components/hourly/return_back_btn.dart';

import '../../../../config/myColor.dart';
import '../../custom_payment/controllers/custom_payment_controller.dart';

class PaymentsView extends GetView<MainHomePageController> {
  final bool isFake;

  const PaymentsView({super.key, this.isFake = false});

  @override
  Widget build(BuildContext context) {
    OrderController.I.paymentMethod.value = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.white,
        title: Text(
          'payment'.tr,
          style: TextStyle(color: MYColor.buttons),
        ),
        centerTitle: true,
        leading: ReturnButton(
          color: MYColor.buttons,
          size: 20.0,
        ),
      ),
      body: GetX(
        init: controller,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                Container(
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
                  // margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width / 3,
                            child: Text(
                              "service".tr,
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 1.8,
                            child: Text(
                              "( ${controller.getServiceModel.name!.tr} ) ${controller.getServiceModel.packages![controller.selectedPackageIndex.value].name!.tr}",
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 14,
                              ),
                              // textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width / 3,
                            child: Text(
                              "package_price".tr,
                              style: TextStyle(
                                color: MYColor.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 1.8,
                            child: Text(
                              "${controller.getServiceModel.packages![controller.selectedPackageIndex.value].price} ${"sar".tr}",
                              style: TextStyle(
                                color: MYColor.grey,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width / 3,
                            child: Text(
                              "duration".tr,
                              style: TextStyle(
                                color: MYColor.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 1.8,
                            child: Text(
                              "${controller.getDuration} ${"month".tr}",
                              style: TextStyle(
                                color: MYColor.grey,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: controller.finalDiscount != 0,
                        child: const Divider(),
                      ),
                      Visibility(
                        visible: controller.finalDiscount != 0,
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width / 3,
                              child: Text(
                                "price_before_discount".tr,
                                style: TextStyle(
                                  color: MYColor.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 1.8,
                              child: Text(
                                "${controller.beforeDiscount} ${"sar".tr}",
                                style: TextStyle(
                                  color: MYColor.grey,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controller.finalDiscount != 0,
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width / 3,
                              child: Text(
                                "discount".tr,
                                style: TextStyle(
                                  color: MYColor.success,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 1.8,
                              child: Text(
                                "${controller.finalDiscount} ${"sar".tr}",
                                style: TextStyle(
                                  color: MYColor.success,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controller.finalDiscount != 0,
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width / 3,
                              child: Text(
                                "price_after_discount".tr,
                                style: TextStyle(
                                  color: MYColor.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 1.8,
                              child: Text(
                                "${controller.finalPrice} ${"sar".tr}",
                                style: TextStyle(
                                  color: MYColor.grey,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width / 3,
                            child: Text(
                              "final_price".tr,
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 1.8,
                            child: Text(
                              "${controller.finalPrice} ${"sar".tr}",
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Text(
                //   "payment_method".tr,
                //   style: TextStyle(
                //     color: MYColor.buttons,
                //     fontSize: 16,
                //     fontFamily: 'cairo_medium',
                //   ),
                // ),
                // const SizedBox(height: 10),
                // ...List.generate(
                //     OrderController.I.fakePaymentMethods.length,
                //     (index) => InkWell(
                //           onTap: () {
                //             OrderController.I.changePaymentMethod(index);
                //           },
                //           child: index == 2
                //               ? Visibility(
                //                   //visible: GetPlatform.isIOS,
                //                   visible: false,
                //                   child: Container(
                //                     padding: const EdgeInsets.all(10.0),
                //                     margin: const EdgeInsets.all(8.0),
                //                     decoration: BoxDecoration(
                //                         borderRadius:
                //                             BorderRadius.circular(10.0),
                //                         border: Border.all(
                //                             width: 1.0,
                //                             color: OrderController.I
                //                                         .paymentMethod?.value ==
                //                                     index
                //                                 ? MYColor.primary
                //                                 : MYColor.white)),
                //                     child: Row(
                //                       children: [
                //                         SvgPicture.asset(
                //                           OrderController.I
                //                               .fakePaymentMethods[index].image,
                //                           height: 30.0,
                //                           width: 30.0,
                //                         ),
                //                         const SizedBox(
                //                           width: 10.0,
                //                         ),
                //                         Text(OrderController
                //                             .I.fakePaymentMethods[index].name)
                //                       ],
                //                     ),
                //                   ))
                //               : Container(
                //                   padding: const EdgeInsets.all(10.0),
                //                   margin: const EdgeInsets.all(8.0),
                //                   decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(10.0),
                //                       border: Border.all(
                //                           width: 1.0,
                //                           color: OrderController
                //                                       .I.paymentMethod.value ==
                //                                   index
                //                               ? MYColor.primary
                //                               : MYColor.white)),
                //                   child: Row(
                //                     children: [
                //                       SvgPicture.asset(
                //                         OrderController
                //                             .I.paymentMethods[index].image,
                //                         height: 20.0,
                //                         width: 20.0,
                //                         // color:
                //                         //     index == 0 ? MYColor.buttons : null,
                //                       ),
                //                       const SizedBox(
                //                         width: 10.0,
                //                       ),
                //                       Text(OrderController
                //                           .I.paymentMethods[index].name)
                //                     ],
                //                   ),
                //                 ),
                //         )),
                const SizedBox(
                  height: 20,
                ),
                myCreditCardButton(context)
              ],
            ),
          );
        },
      ),
    );
  }

  ///My Credit Card Button
  Widget myCreditCardButton(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Container(
        height: 50,
        width: Get.width - 10,
        decoration: BoxDecoration(
          color: MYColor.accent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(1),
        child: CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 45,
            onPressed: () {
               MainHomePageController.I
                  .postOrderToServer(context,isPaid: false, showSuccess: true);
            },
            color: MYColor.white,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    OrderController
                        .I
                        .paymentMethods[1]
                        .name,
                    style: TextStyle(
                      color: MYColor.buttons,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cairo_regular',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      width: 25.0,
                      height: 25.0,
                      OrderController
                          .I
                          .paymentMethods[1]
                          .image,
                      fit: BoxFit.contain,
                      // color: OrderController.I.paymentMethod.value == 0?MYColor.buttons : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      
    );
  }

  ///My Apple Pay Button
  Widget myApplePayButton(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width - 10,
      decoration: BoxDecoration(
        color: MYColor.accent,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(1),
      child: CupertinoButton(
        onPressed: () {
          // CustomPaymentController.I.applePay(1.00, true);
          CustomPaymentController.I.applePay(controller.finalPrice, isFake);
        },
        color: MYColor.black,
        padding: EdgeInsets.zero,
        child: SvgPicture.asset(
          "assets/images/old_apple_pay.svg",
          width: 45,
          height: 25,
          color: MYColor.white,
        ),
      ),
    );
  }
}
