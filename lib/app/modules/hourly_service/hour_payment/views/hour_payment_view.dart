import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/custom_payment/controllers/custom_payment_controller.dart';
import 'package:musaneda/app/modules/order/controllers/order_controller.dart';
import 'package:musaneda/app/modules/order/views/tabby_stc_paymentview/components/tabby_method.dart';
import 'package:musaneda/components/hourly/return_back_btn.dart';
import 'package:musaneda/components/myCupertinoButton.dart';
import 'package:musaneda/config/myColor.dart';

class HourPaymentView extends GetView<OrderController> {
  const HourPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final customPaymentController = Get.put(CustomPaymentController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MYColor.primary.withOpacity(0.1),
        title: Text('payment'.tr,
            style: TextStyle(color: MYColor.primary, fontSize: 18.0)),
        leading: ReturnButton(color: MYColor.primary, size: 20.0),
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
       // color: MYColor.primary.withOpacity(0.1),
        height: double.infinity,
        width: double.infinity,
        child: GetBuilder<OrderController>(
           builder: (controller) {
            return Column(children: [
              // Container(
              //   height: 40,
              //   width: Get.width,
              //   decoration: BoxDecoration(
              //     color: MYColor.primary.withOpacity(0.1),
              //     borderRadius: const BorderRadius.only(
              //       bottomLeft: Radius.circular(20),
              //       bottomRight: Radius.circular(20),
              //     ),
              //   ),
              // ),
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
                        const SizedBox(height: 15.0,),
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
                tabbyMethod(context, 2000.0),
                //const SizedBox(height: 20),
            const Spacer(),
            
                 SizedBox(
                    width: Get.width,
                    height: 50.0,
                    child: MyCupertinoButton(
                        fun: () {
                         
                        },
                        text: 'pay'.tr,
                        btnColor: MYColor.buttons,
                        txtColor: MYColor.btnTxtColor),
                  )
            ],);
          }
        ),
      ),
    );
  }
}