import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/routes/app_pages.dart';
import 'package:musaneda/components/myInkWell.dart';
import 'package:musaneda/config/myColor.dart';

import '../../../../components/myCupertinoButton.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      key: const ValueKey("login-view"),
      body: GetBuilder(
        init: controller,
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: controller.formLoginKey,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: Get.height / 20,
                      ),
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
                      Positioned(
                        top: 10.0,
                        right: LanguageController.I.isEnglish ? 0.0 : null,
                        left: LanguageController.I.isEnglish ? null : 0.0,
                        child: Obx(
                          () => Container(
                            child: DropdownButton(
                              borderRadius: BorderRadius.circular(20.0),
                              elevation: 1,
                              iconEnabledColor: MYColor.buttons,
                              alignment: AlignmentDirectional.centerEnd,
                              value: controller.selectedLanguage.value,
                              dropdownColor: MYColor.white,
                              items: controller.languageList
                                  .map((item) => DropdownMenuItem(
                                      value: item.id!,
                                      child: Text(
                                        LanguageController.I.isEnglish
                                            ? item.name!.en!
                                            : item.name!.ar!,
                                        style:
                                            TextStyle(color: MYColor.primary),
                                      )))
                                  .toList(),
                              onChanged: (value) {
                                if (value != 0) {
                                  LanguageController.I
                                      .updateLangForLOGINSIGNUP(value!);
                                  controller.selectedLanguage.value = value;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 10.0,
                          right: LanguageController.I.isEnglish ? null : 0.0,
                          left: LanguageController.I.isEnglish ? 0.0 : null,
                          child: TextButton(
                              onPressed: controller.checkServiceType,
                              child: Text(
                                "skip".tr,
                                style: TextStyle(
                                    color: MYColor.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )))
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      "sign_in".tr,
                      style: TextStyle(
                        color: MYColor.buttons,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  _phoneTextField(context),
                  const SizedBox(height: 10),
                  _passwordTextField(context),
                  const SizedBox(height: 25),
                  Align(
                    alignment: LanguageController.I.getLocale == "ar"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: myInkWell(
                      fun: () {
                        Get.toNamed(Routes.FORGET);
                      },
                      text: "forgot_password".tr,
                      size: 14,
                      font: 'cairo_regular',
                      color: MYColor.buttons,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: MyCupertinoButton(
                      btnColor: MYColor.buttons,
                      txtColor: MYColor.btnTxtColor,
                      text: "sign_in".tr,
                      fun: () => controller.login(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "do_not_have_an_account".tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      myInkWell(
                        fun: () {
                          Get.offAllNamed(Routes.REGISTER);
                        },
                        text: "create_one".tr,
                        size: 14,
                        font: 'cairo_regular',
                        color: MYColor.buttons,
                      ),
                    ],
                  ),
                ],
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
      // inputFormatters: [
      //   //FilteringTextInputFormatter.digitsOnly,
      // ],
      textAlign: TextAlign.left,
      validator: (value) => controller.validatePhone(value!),
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
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
            // width: 103,
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

  /// password text field
  TextFormField _passwordTextField(BuildContext context) {
    return TextFormField(
      autofillHints: const [AutofillHints.password],
      controller: controller.txtPassword,
      keyboardType: TextInputType.visiblePassword,
      obscureText: controller.obscureText.value,
      validator: (value) => controller.validatePassword(value!),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: "password".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        prefixIcon: Icon(
          CupertinoIcons.padlock,
          color: MYColor.buttons,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        suffixIcon: IconButton(
          splashRadius: 10,
          onPressed: () => controller.toggleObscureText(),
          icon: controller.getIcon(),
        ),
      ),
    );
  }
}
