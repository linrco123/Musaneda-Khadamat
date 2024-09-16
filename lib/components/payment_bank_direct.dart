import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/order/controllers/order_controller.dart';
import 'package:musaneda/config/myColor.dart';

class BankAccountPayment extends StatelessWidget {
  const BankAccountPayment({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = Get.locale!.languageCode == 'ar';
    return Obx(
      () => GestureDetector(
        onTap: () {
          OrderController.I.changepaymentBankOption();
        },
        child: Container(
          width: double.infinity, // 315,
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MYColor.white,
            border: Border.all(
              color: !OrderController.I.paymentBank.value
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
          child: Padding(
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
                                text: 'payment_bank'.tr,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'cairo_regular',
                                    height: 1.5,
                                    fontSize: 15), // Normal font style
                              ),
                            ],
                          ),
                        )
                      : RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'payment_bank'.tr,
                                style: const TextStyle(
                                    fontFamily: 'cairo_regular',
                                    color: Colors.black,
                                    height: 1.5,
                                    fontSize: 16), // Normal font style
                              ),
                            ],
                          ),
                        ),
                ),
                Padding(
                    padding: isArabic
                        ? const EdgeInsets.only(left: 10)
                        : const EdgeInsets.only(right: 10),
                    child: Container(
                        height: 60,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/payment-bank.png',
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: MYColor.primary.withOpacity(0.1),
                                offset: const Offset(1, 0),
                                blurRadius: 5,
                                spreadRadius: 0,
                              ),
                            ]))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
