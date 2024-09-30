import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/app/modules/custom_payment/providers/custom_payment_provider.dart';
import 'package:musaneda/app/modules/main_home_page/contract_model.dart';
import 'package:musaneda/app/modules/order/controllers/order_controller.dart';
import 'package:musaneda/components/mySnackbar.dart';
import 'package:musaneda/config/constance.dart';
import 'package:musaneda/config/myColor.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../../main_home_page/controllers/main_home_page_controller.dart';

class CustomPaymentController extends GetxController {
  static CustomPaymentController get I => Get.put(CustomPaymentController());
  static const platform = MethodChannel('com.fnrco.musaneda/channel');
  final box = GetStorage();

  // String testCreditcardEntityID = '8ac7a4c7820e3114018211080d2518e9';
  // String testMadaEntityID = '8ac7a4c7820e31140182110885b518ed';
  // String testApplePayEntityID = '8ac7a4c782187c3001821b83cc291a17';

  String liveVisaMasterEntityID = '8acda4c7860d0a25018625c11cfb0aaf';
  String liveMadaEntityID = '8acda4c7860d0a25018625c1d3aa0ab6';
  String liveApplePayEntityID = '8acda4c7860d0a25018625c28fd80abb';

  String stcPayEntityID = '';
  String resultText = '';

  // String madaRegexV =
  //     "4(0(0861|1757|7(197|395)|9201)|1(0685|7633|9593)|2(281(7|8|9)|8(331|67(1|2|3)))|3(1361|2328|4107|9954)|4(0(533|647|795)|5564|6(393|404|672))|5(5(036|708)|7865|8456)|6(2220|854(0|1|2|3))|8(301(0|1|2)|4783|609(4|5|6)|931(7|8|9))|93428)";
  // String madaRegexM =
  //     "5(0(4300|8160)|13213|2(1076|4(130|514)|9(415|741))|3(0906|1095|2013|5(825|989)|6023|7767|9931)|4(3(085|357)|9760)|5(4180|7606|8848)|8(5265|8(8(4(5|6|7|8|9)|5(0|1))|98(2|3))|9(005|206)))|6(0(4906|5141)|36120)|9682(0(1|2|3|4|5|6|7|8|9)|1(0|1))";
  //
  //
  String madaHash = "";

  String madaRegexV =
      "4(0(0861|1757|7(197|395)|9201)|1(0685|7633|9593)|2(281(7|8|9)|8(331|67(1|2|3)))|3(1361|2328|4107|9954)|4(0(533|647|795)|5564|6(393|404|672))|5(5(036|708)|7865|8456)|6(2220|854(0|1|2|3))|8(301(0|1|2)|4783|609(4|5|6)|931(7|8|9))|93428)";
  String madaRegexM =
      "5(0(4300|8160)|13213|2(1076|4(130|514)|9(415|741))|3(0906|1095|2013|5(825|989)|6023|7767|9931)|4(3(085|357)|9760)|5(4180|7606|8848)|8(5265|8(8(4(5|6|7|8|9)|5(0|1))|98(2|3))|9(005|206)))|6(0(4906|5141)|36120)|9682(0(1|2|3|4|5|6|7|8|9)|1(0|1))";

  final uuid = const Uuid();

  final cardNumberController = TextEditingController();
  final cardHolderController = TextEditingController();
  final cardExpiryController = TextEditingController();
  final cardCvvController = TextEditingController();
  final stcPayController = TextEditingController();

  final isPayOrder = false.obs;

  final contractModel = ContractData().obs;

  set setContractModel(ContractData setContractModel) {
    contractModel.value = setContractModel;
    update();
  }

  set setIsPayOrder(bool setIsPayOrder) {
    isPayOrder.value = setIsPayOrder;
    update();
  }

  final formOrderKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  FocusNode cardHolderFocus = FocusNode();
  FocusNode cardNumberFocus = FocusNode();
  FocusNode cardNumberFocusNode = FocusNode();
  FocusNode cardExpiryDateFocusNode = FocusNode();
  FocusNode cardCvvFocusNode = FocusNode();

  String merchantTransactionID = '';

  setMerchantTransactionID() {
    merchantTransactionID = uuid.v4();
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setMerchantTransactionID();
  }

  String get getMerchantTransactionID => merchantTransactionID;

  bool validate() {
    if (cardNumberController.text.isEmpty) {
      return false;
    }
    if (cardHolderController.text.isEmpty) {
      return false;
    }
    if (cardExpiryController.text.isEmpty) {
      return false;
    }
    if (cardCvvController.text.isEmpty) {
      return false;
    }
    return true;
  }

  // Future<void> payWithAmazon({bool isFake = false}) async {
  //   var amazonPay = Get.put(AmazonPayController());

  //   if (!isFake) {
  //     try {
  //       final transactionId = await amazonPay.transactionIdProvider
  //           .updateTransactionId(
  //               transactionId: const Uuid().v4(),
  //               orderId: OrderController.I.orderID);
  //       OrderController.I.merchantTransactionID =
  //           transactionId.data!.transactionId!;
  //     } catch (e, s) {
  //       await Sentry.captureException(e, stackTrace: s);
  //     }
  //   }

  //   if (OrderController.I.paymentMethod.value != 10 ||
  //       OrderController.I.tabbyOption.value == true) {
  //     if (OrderController.I.tabbyOption.value) {
  //       Get.put(TabbyPaymentController());
  //       Get.to(const TabbyPaymentView(), arguments: [
  //         OrderController.I.merchantTransactionID,
  //         OrderController.I.orderID
  //       ]);
  //     } else {
  //       if (OrderController.I.paymentMethod.value == 0 ||
  //           OrderController.I.paymentMethod.value == 1) {
  //         //credit card - MADA
  //         AmazonPayController.I.paymentWithCreditOrDebitCard(
  //           onSucceeded: (result) async {
  //             mySnackBar(
  //               title: "success".tr,
  //               message: "payment_success".tr,
  //               color: MYColor.success,
  //               icon: CupertinoIcons.info_circle,
  //             );
  //             if (!isFake) {
  //               await CustomPaymentProvider().sendTransactionPay(
  //                 transactionId:
  //                     OrderController.I.merchantTransactionID.toString(),
  //                 orderId: OrderController.I.orderID,
  //                 paymentOption: 'Credit Card',
  //               );
  //               Get.offAllNamed(Routes.HOME);
  //             } else {
  //               if (isPayOrder.value) {
  //                 MainHomePageController.I
  //                     .payOrder(isPaid: false, showSuccess: true);
  //               } else {
  //                 MainHomePageController.I.postOrderToServer(context,
  //                     isPaid: true, showSuccess: true);
  //               }
  //             }
  //           },
  //           onFailed: (error) {
  //             mySnackBar(
  //               title: "error".tr,
  //               message: "payment_failed".tr,
  //               color: MYColor.warning,
  //               icon: CupertinoIcons.info_circle,
  //             );
  //             log('  onFailed: (error) { credited card ');
  //             if (isFake) {
  //               if (isPayOrder.value) {
  //                 MainHomePageController.I.payOrder(
  //                   isPaid: false,
  //                 );
  //               }
  //               MainHomePageController.I
  //                   .postOrderToServer(context, isPaid: false);
  //             }
  //           },
  //           onCancelled: () {
  //             log('  onCancelled: (error) { credited card ');
  //             mySnackBar(
  //               title: "error".tr,
  //               message: "payment_failed".tr,
  //               color: MYColor.warning,
  //               icon: CupertinoIcons.info_circle,
  //             );
  //             if (isFake) {
  //               if (isPayOrder.value) {
  //                 MainHomePageController.I.payOrder(
  //                   isPaid: false,
  //                 );
  //               }
  //               MainHomePageController.I
  //                   .postOrderToServer(context, isPaid: false);
  //             }
  //           },
  //           amount: isFake
  //               ? MainHomePageController.I.finalPrice.toInt()
  //               : OrderController.I.packagesData.total!.toInt(),
  //           customerEmail: Constance.instance.email,
  //           customerName: Constance.instance.name,
  //           phoneNumber: Constance.instance.phone,
  //           merchantReference: OrderController.I.merchantTransactionID,
  //         );
  //       } else if (OrderController.I.paymentMethod.value == 2) {
  //         AmazonPayController.I.paymentWithApplePay(
  //           onSucceeded: (result) async {
  //             mySnackBar(
  //               title: "success".tr,
  //               message: "payment_success".tr,
  //               color: MYColor.success,
  //               icon: CupertinoIcons.info_circle,
  //             );
  //             if (!isFake) {
  //               await CustomPaymentProvider().sendTransactionPay(
  //                 transactionId:
  //                     OrderController.I.merchantTransactionID.toString(),
  //                 orderId: OrderController.I.orderID,
  //                 // from transactionId to orderId
  //                 paymentOption: 'Apple',
  //               );
  //               Get.offAllNamed(Routes.HOME);
  //             } else {
  //               if (isPayOrder.value) {
  //                 MainHomePageController.I.payOrder(
  //                   isPaid: false,
  //                 );
  //               }
  //               MainHomePageController.I
  //                   .postOrderToServer(context, isPaid: true);
  //             }
  //           },
  //           onFailed: (error) {
  //             mySnackBar(
  //               title: "error".tr,
  //               message: "payment_failed".tr,
  //               color: MYColor.warning,
  //               icon: CupertinoIcons.info_circle,
  //             );
  //             if (isFake) {
  //               if (isPayOrder.value) {
  //                 MainHomePageController.I.payOrder(
  //                   isPaid: false,
  //                 );
  //               }
  //               MainHomePageController.I
  //                   .postOrderToServer(context, isPaid: false);
  //             }
  //           },
  //           amount: isFake
  //               ? MainHomePageController.I.finalPrice.toInt()
  //               : OrderController.I.packagesData.total!.toInt(),
  //           customerEmail: Constance.instance.email,
  //           customerName: Constance.instance.name,
  //           phoneNumber: Constance.instance.phone,
  //           merchantReference: OrderController.I.merchantTransactionID,
  //         );
  //       } else {
  //         Get.put(StcPayPaymentController());
  //         Get.to(const STCPaymentView(), arguments: [
  //           OrderController.I.merchantTransactionID,
  //           OrderController.I.orderID
  //         ]);
  //       }
  //     }
  //   } else {
  //     OrderController.I.checkOrder(isDone: false);
  //   }
  // }

  Map getBody(entityID, amount) {
    setMerchantTransactionID();
    return {
      // change_amount
      'amount': '1',
      'entityID': entityID,
      'username': Constance.instance.name,
      'merchantTransactionId': getMerchantTransactionID,
      'address': 'Riyadh',
      'city': 'Riyadh',
    };
  }

  Future<void> getPayments({
    required isFake,
    required entityID,
    required checkoutID,
  }) async {
    Map data = {
      'entityID': entityID,
      'checkoutID': checkoutID,
    };

    log(data.toString(), name: 'getPayments');
    CustomPaymentProvider().payments(data).then(
      (response) {
        log(
          response.result.description,
          name: 'payments_response_result_descriptions',
          error: response.result.code,
        );
        switch (paymentStatusFromRegExp(response.result.code)) {
          case PaymentStatus.init:
            mySnackBar(
              title: "progress".tr,
              message: "progress_msg".tr,
              color: MYColor.sadad,
              icon: Icons.info_outline,
            );
            if (isFake) {
              if (isPayOrder.value) {
                MainHomePageController.I.payOrder(
                  isPaid: false,
                );
              }
              MainHomePageController.I.postOrderToServer(
                context,
                isPaid: false,
              );
            }
            OrderController.I.checkOrder(isDone: false);

            break;
          case PaymentStatus.successful:
            mySnackBar(
              title: "success".tr,
              message: "success_msg".tr,
              color: MYColor.success,
              icon: Icons.check,
            );
            if (isFake) {
              if (isPayOrder.value) {
                MainHomePageController.I.payOrder(
                  isPaid: false,
                );
              }
              MainHomePageController.I.postOrderToServer(
                context,
                isPaid: true,
              );
            }
            OrderController.I.checkOrder(isDone: true);
            break;
          case PaymentStatus.pending:
            mySnackBar(
              title: "pending".tr,
              message: "pending_msg".tr,
              color: MYColor.warning,
              icon: Icons.access_time,
            );
            if (isFake) {
              if (isPayOrder.value) {
                MainHomePageController.I.payOrder(
                  isPaid: false,
                );
              }
              MainHomePageController.I.postOrderToServer(
                context,
                isPaid: false,
              );
            }
            OrderController.I.checkOrder(isDone: false);
            break;
          case PaymentStatus.rejected:
            mySnackBar(
              title: "rejected".tr,
              message: response.result.description,
              // message: "rejected_msg".tr,
              color: MYColor.danger,
              icon: Icons.cancel_outlined,
            );
            // if (isFake) {
            //   if (isPayOrder.value) {
            //     MainHomePageController.I.payOrder(
            //       isPaid: false,
            //     );
            //   }
            //   MainHomePageController.I.postOrderToServer(
            //     response: response,
            //     isPaid: false,
            //     type: "apple_pay",
            //   );
            // }
            break;
        }
      },
    );

    update();
  }

  Future<void> applePay(double? amount, bool isFake) async {
    log(
      'APPLEPAY',
      name: "brand_type_name",
    );
    CustomPaymentProvider()
        .checkout(getBody(liveApplePayEntityID, amount))
        .then((response) async {
      if (response.result.code == "000.200.100") {
        try {
          final String result = await platform.invokeMethod(
            'get_hyperpay_response',
            {
              "type": "CustomUI",
              "mode": "LIVE",
              "checkoutID": response.id,
              "brand": "APPLEPAY",
              "card_number": '',
              "holder_name": '',
              "month": '',
              "year": '',
              "cvv": '',
              "MadaRegexV": madaRegexV,
              "MadaRegexM": madaRegexM,
              "stcPay": "disabled",
              // change_amount
              "Amount": amount,
            },
          );

          if (result.isNotEmpty || result == "success" || result == "SYNC") {
            await getPayments(
              entityID: liveApplePayEntityID,
              checkoutID: response.id,
              isFake: isFake,
            );
          } else {
            Get.snackbar(
              'Error',
              result,
              snackPosition: SnackPosition.TOP,
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );
          }
        } on PlatformException catch (e) {
          log("$e", name: "apple_pay_platform_invoke");
        }
      } else {
        Get.snackbar(
          'Error',
          response.result.description,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });

    update();
  }

  Future<void> stcPay(amount, isFake) async {
    if (stcPayController.text.isNotEmpty) {
      CustomPaymentProvider()
          .checkout(getBody(stcPayEntityID, amount))
          .then((response) async {
        if (response.result.code == "000.200.100") {
          try {
            final String result = await platform.invokeMethod(
              'get_hyperpay_response',
              {
                "type": "CustomUI",
                "checkoutID": response.id,
                "mode": "LIVE",
                "card_number": cardNumberController.text,
                "holder_name": cardHolderController.text,
                "month": cardExpiryController.text.substring(0, 2),
                "year": cardExpiryController.text.substring(3, 5),
                "cvv": cardCvvController.text,
                "stcPay": "enabled"
              },
            );

            if (result.isNotEmpty || result == "success" || result == "SYNC") {
              await getPayments(
                entityID: stcPayEntityID,
                checkoutID: response.id,
                isFake: isFake,
              );
            } else {
              Get.snackbar(
                'Error',
                result,
                snackPosition: SnackPosition.TOP,
                colorText: Colors.white,
                backgroundColor: Colors.green,
              );
            }
          } on PlatformException catch (e) {
            log("$e", name: "func => stcPay");
          }
        } else {
          Get.snackbar(
            'Error',
            response.result.description,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      });
    } else {
      Get.snackbar(
        "Alert",
        'Please fill the STC Pay Number',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    }
    update();
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    cardHolderController.dispose();
    cardExpiryController.dispose();
    cardCvvController.dispose();
    stcPayController.dispose();
    super.onClose();
  }
}

PaymentStatus paymentStatusFromRegExp(String code) {
  final successRegExp = RegExp(
      r"^(000\.000\.|000\.100\.1|000\.[36]|000\.400\.0[^3]|000\.400\.[0-1]{2}0)");
  final pendingRegExp = RegExp(r"^(000\.200|800\.400\.5|100\.400\.500)");

  if (successRegExp.hasMatch(code)) {
    return PaymentStatus.successful;
  } else if (pendingRegExp.hasMatch(code)) {
    return PaymentStatus.pending;
  } else {
    return PaymentStatus.rejected;
  }
}

enum PaymentStatus {
  init,
  successful,
  pending,
  rejected,
}
