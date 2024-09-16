import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/routes/app_pages.dart';
import 'package:musaneda/config/constance.dart';
import 'package:musaneda/config/myColor.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BankAccountdetails extends StatelessWidget {
  const BankAccountdetails({super.key});

  @override
  Widget build(BuildContext context) {
     String orderId = Get.arguments['orderID'];
    double totalPrice = double.parse(Get.arguments['totalPrice'].toString());
    String page = Get.arguments['page'];
     return Scaffold(
      appBar: AppBar(
        title: Text('bank_accounts'.tr),
        backgroundColor: MYColor.primary,
        leading: IconButton(
            onPressed: () {
              if (page == 'order') {
                Get.offAllNamed(Routes.HOME);
              }
              if (page == 'hour') {
                Get.back();
               // Get.offAllNamed(Routes.SERVICETYPE);
              }
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: MYColor.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: MYColor.primary, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'won'.tr, //'order_number'.tr
                          style: TextStyle(
                              fontSize: 20.0,
                              color: MYColor.primary,
                              fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          orderId.toString(),
                          style: TextStyle(
                              fontSize: 20.0,
                              color: MYColor.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2.0,
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      text: TextSpan(
                        text: 'bank_script'.tr.trim(),
                        style: TextStyle(color: MYColor.grey, fontSize: 16.0),
                        children: <TextSpan>[
                          const TextSpan(text: ' '),
                          TextSpan(
                              text:
                                  Constance.technicalSupport_phone.toString(),
                              style: TextStyle(color: MYColor.primary)),
                        ],
                      ),
                    )),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'money_should_pay'.tr,
                            style: TextStyle(
                                color: MYColor.primary,
                                fontSize: 17.0),
                            children: [
                          TextSpan(
                              text:
                                  LanguageController.I.isEnglish ? ' : ' : ' : ',
                              style: TextStyle(color: MYColor.primary)),
                          TextSpan(
                              text: totalPrice.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MYColor.black)),
                          TextSpan(
                              text: LanguageController.I.isEnglish
                                  ? ' SAR'
                                  : ' ريال',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: MYColor.primary))
                        ])),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 3.0,
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assets/images/rajhi1.png',
                      height: 50.0,
                      width: 170.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: MYColor.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'bank_account'.tr,
                      style: TextStyle(
                          color: MYColor.primary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w900),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        ':',
                        style:
                            TextStyle(color: MYColor.primary, fontSize: 18.0),
                      ),
                    ),
                    SelectableText(
                      Constance.ALrajhi_BankAccount,
                      style:
                          TextStyle(fontSize: 17.0, color: MYColor.greyDeep),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg: 'copied_clipboard'.tr,
                            backgroundColor: MYColor.primary,
                            gravity: ToastGravity.CENTER_RIGHT,
                          );
                          Clipboard.setData(const ClipboardData(
                              text: Constance.ALrajhi_BankAccount));
                        },
                        icon: Icon(
                          Icons.copy,
                          color: MYColor.primary,
                          size: 18.0,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: MYColor.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
      
                    Text(
                      'iban'.tr,
                      style: TextStyle(
                          color: MYColor.primary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w900),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        ':',
                        style:
                            TextStyle(color: MYColor.primary, fontSize: 18.0),
                      ),
                    ),
                    SelectableText(
                      Constance.ALrajhi_BankAccountIBAN,
                      style:
                          TextStyle(fontSize: 17.0, color: MYColor.greyDeep),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg: 'copied_clipboard'.tr,
                            backgroundColor: MYColor.primary,
                            gravity: ToastGravity.CENTER_RIGHT,
                          );
                          Clipboard.setData(const ClipboardData(
                              text: Constance.ALrajhi_BankAccountIBAN));
                        },
                        icon: Icon(
                          Icons.copy,
                          color: MYColor.primary,
                          size: 18.0,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //   Card(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.0)),
              //     elevation: 3.0,
              //     clipBehavior: Clip.antiAlias,
              //     child: Image.asset(
              //       'assets/images/alinma.jpeg',
              //       height: 50.0,
              //       width: 170.0,
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              // ]),
              // const SizedBox(
              //   height: 20.0,
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: MYColor.primary.withOpacity(0.1),
              //       borderRadius: BorderRadiusDirectional.circular(10.0)),
              //   child: Row(
              //     children: [
              //       const SizedBox(
              //         width: 10.0,
              //       ),
              //       Text(
              //         'bank_account'.tr,
              //         style: TextStyle(
              //             color: MYColor.primary,
              //             fontSize: 14.0,
              //             fontWeight: FontWeight.w900),
              //       ),
              //        Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 2.0),
              //         child: Text(
              //           ':',
              //           style:
              //               TextStyle(color: MYColor.primary, fontSize: 18.0),
              //         ),
              //       ),
              //       SelectableText(
              //         Constance.ALinma_BankAccount,
              //         style:
              //             TextStyle(fontSize: 17.0, color: MYColor.greyDeep),
              //       ),
              //       const Spacer(),
              //       IconButton(
              //           onPressed: () {
              //             Fluttertoast.showToast(
              //               msg: 'copied_clipboard'.tr,
              //               backgroundColor: MYColor.primary,
              //               gravity: ToastGravity.CENTER_RIGHT,
              //             );
              //             Clipboard.setData(const ClipboardData(
              //                 text: Constance.ALinma_BankAccount));
              //           },
              //           icon: Icon(
              //             Icons.copy,
              //             color: MYColor.primary,
              //             size: 18.0,
              //           )),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 10.0,
              // ),
              //  Container(
              //   decoration: BoxDecoration(
              //       color: MYColor.primary.withOpacity(0.1),
              //       borderRadius: BorderRadiusDirectional.circular(10.0)),
              //   child: Row(
              //     children: [
              //       const SizedBox(
              //         width: 10.0,
              //       ),
              //       Text(
              //         'iban'.tr,
              //         style: TextStyle(
              //             color: MYColor.primary,
              //             fontSize: 14.0,
              //             fontWeight: FontWeight.w900),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 2.0),
              //         child: Text(
              //           ':',
              //           style:
              //               TextStyle(color: MYColor.primary, fontSize: 18.0),
              //         ),
              //       ),
              //       SelectableText(
              //         Constance.ALinma_BankAccountIBAN,
              //         style:
              //             TextStyle(fontSize: 17.0, color: MYColor.greyDeep),
              //       ),
              //       const Spacer(),
              //       IconButton(
              //           onPressed: () {
              //             Fluttertoast.showToast(
              //               msg: 'copied_clipboard'.tr,
              //               backgroundColor: MYColor.primary,
              //               gravity: ToastGravity.CENTER_RIGHT,
              //             );
              //             Clipboard.setData(const ClipboardData(
              //                 text: Constance.ALinma_BankAccountIBAN));
              //           },
              //           icon: Icon(
              //             Icons.copy,
              //             color: MYColor.primary,
              //             size: 18.0,
              //           )),
              //     ],
              //   ),
              // ),
               const SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
