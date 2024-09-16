import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/order/controllers/order_controller.dart';
import 'package:musaneda/config/myColor.dart';

Widget tabbyMethod(BuildContext context, double totalPrice) {
  var isArabic = Get.locale!.languageCode == 'ar';
  var price = totalPrice / 4;
  return Obx(
    () => GestureDetector(
      onTap: () {
        OrderController.I.changeTabbyOption();
      },
      child: Container(
        width: double.infinity, // 315,
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MYColor.white,
          border: Border.all(
            color: !OrderController.I.tabbyOption.value
                ? MYColor.grey.withOpacity(0.5)
                : MYColor.primary,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: MYColor.primary.withOpacity(0.5),
              offset: const Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: isArabic
                  ? const EdgeInsets.only(top: 5, right: 20)
                  : const EdgeInsets.only(top: 5, left: 20),
              child: Row(
                children: [
                  Expanded(
                    child: isArabic
                        ? RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${'tabby_des1'.tr} ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'cairo_regular',
                                      height: 1.5,
                                      fontSize: 15), // Normal font style
                                ),
                                TextSpan(
                                  text: '${price.toString()} SAR ',
                                  style: const TextStyle(
                                      fontFamily: 'cairo_regular',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      height: 1.5), // Bold font style
                                ),
                                // TextSpan(
                                //   text: 'tabby_des2'.tr,
                                //   style: const TextStyle(
                                //       color: Colors.black,
                                //       height: 1.5,
                                //       fontSize: 15), // Normal font style
                                // ),
                              ],
                            ),
                          )
                        : RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${'tabby_des1'.tr} ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'cairo_regular',
                                      height: 1.5), // Normal font style
                                ),
                                TextSpan(
                                  text: '$price SAR.',
                                  style: const TextStyle(
                                    fontFamily: 'cairo_regular',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  Padding(
                    padding: isArabic
                        ? const EdgeInsets.only(top: 5, left: 15)
                        : const EdgeInsets.only(top: 5, right: 15),
                    child: Image.asset(
                      'assets/images/tabby.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
