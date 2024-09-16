import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';

import '../../../../components/myCupertinoButton.dart';
import '../../../../components/myInkWell.dart';
import '../../../../config/myColor.dart';
import '../../../routes/app_pages.dart';
import '../controllers/forget_controller.dart';

class ForgetView extends GetView<ForgetController> {
  const ForgetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: controller,
        builder: (ctx) {
          return Container(
            color: MYColor.primary.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: controller.formForgetKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: Get.height / 10,
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 0.0, top: 0.0),
                        child: Center(
                          child: Image.asset(
                            'assets/images/hamaLogo.png',
                            height: 80.0,
                            width: 150.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: Text(
                        "reset_password".tr,
                        style: TextStyle(
                          color: MYColor.buttons,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    _phoneTextField(context),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 52,
                      width: double.infinity,
                      child: MyCupertinoButton(
                        btnColor: MYColor.buttons,
                        txtColor: MYColor.btnTxtColor,
                        text: "send_verification_code".tr,
                        fun: () => controller.forgotPassword(context),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "back_to_login".tr,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        myInkWell(
                          fun: () {
                            Get.offAllNamed(Routes.LOGIN);
                          },
                          text: "sign_in".tr,
                          size: 14,
                          font: 'cairo_regular',
                          color: MYColor.buttons,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// phone text field
  TextFormField _phoneTextField(BuildContext context) {
    return TextFormField(
      autofillHints: const [AutofillHints.telephoneNumber],
      controller: controller.txtPhone,
      keyboardType: TextInputType.phone,
      inputFormatters: const [
       // FilteringTextInputFormatter.digitsOnly,
      ],
      textAlign: TextAlign.left,
      validator: (value) => controller.validatePhone(value!),
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        // prefixText: "phone_number".tr,
        // hintText: "phone_number".tr,
        suffixIcon: LanguageController.I.isEnglish
            ? const SizedBox()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 5.0),
                child: Text(
                  "966+",
                  style: TextStyle(
                    color: MYColor.secondary1,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        hintText: "5XXXXXXX".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        prefixIcon: Padding(
          padding: LanguageController.I.isEnglish
              ? const EdgeInsets.only(left: 15, right: 0)
              : const EdgeInsets.only(left: 0, right: 15),
          child: SizedBox(
            //width: 103,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.phone,
                  color: MYColor.buttons,
                ),
                const SizedBox(width: 10),
                Text(
                  "phone_number".tr,
                  style: TextStyle(
                    color: MYColor.primary,
                    fontSize: 14,
                  ),
                ),
                LanguageController.I.isEnglish
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 5.0),
                        child: Text(
                          "+966",
                          style: TextStyle(
                            color: MYColor.secondary1,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),

        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
