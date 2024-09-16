import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/home/controllers/home_controller.dart';
import 'package:musaneda/app/modules/register/views/terms_conditions_webview.dart';

import '../../../../components/myCupertinoButton.dart';
import '../../../../components/myInkWell.dart';
import '../../../../config/myColor.dart';
import '../../../routes/app_pages.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: GetBuilder(
        init: controller,
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: controller.formRegisterKey,
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
                          margin:
                              const EdgeInsets.only(bottom: 0.0, top: 0.0),
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
                              value: LoginController.I.selectedLanguage.value,
                              dropdownColor: MYColor.white,
                              items: LoginController.I.languageList
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
                                  LoginController.I.selectedLanguage.value =
                                      value;
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
                      "sign_up".tr,
                      style: TextStyle(
                        color: MYColor.buttons,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  _nameTextField(context),
                  const SizedBox(height: 10),
                  _phoneTextField(context),
                  const SizedBox(height: 10),
                  _iqamaTextField(context),
                  // const SizedBox(height: 10),
                  // _emailTextField(context),
                  const SizedBox(height: 10),
                  _passwordTextField(context),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        child: Text(
                          "by_clicking_on_create".tr,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      myInkWell(
                        fun: () {
                          Get.put(HomeController());
                          Get.to(const TermsConditionsWebview());
                        },
                        text: "terms_and_conditions",
                        size: 14,
                        font: 'cairo_regular',
                        color: MYColor.buttons,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: MyCupertinoButton(
                      btnColor: MYColor.buttons,
                      txtColor: MYColor.btnTxtColor,
                      text: "create_an_account".tr,
                      fun: () => controller.register(context),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "already_have_an_account".tr,
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
          );
        },
      ),
    );
  }

  /// full name text field
  TextFormField _nameTextField(BuildContext context) {
    return TextFormField(
      autofillHints: const [AutofillHints.name],
      controller: controller.txtFullName,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.start,
      validator: (value) => controller.validateFullName(value!),
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: "full_name".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        prefixIcon: Icon(
          CupertinoIcons.person,
          color: MYColor.buttons,
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

  /// phone text field
  TextFormField _phoneTextField(BuildContext context) {
    return TextFormField(
      autofillHints: const [AutofillHints.telephoneNumber],
      controller: controller.txtPhone,
      keyboardType: TextInputType.phone,
      inputFormatters: const [
        //FilteringTextInputFormatter.digitsOnly,
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

  /// iqama text field
  TextFormField _iqamaTextField(BuildContext context) {
    return TextFormField(
      // autofillHints: const [AutofillHints.telephoneNumber],
      controller: controller.txtIqama,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      textAlign: TextAlign.start,
      validator: (value) => controller.validateIqama(value!),
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: "iqama_number".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        prefixIcon: Icon(
          CupertinoIcons.creditcard,
          color: MYColor.buttons,
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

  /// email text field
  TextFormField _emailTextField(BuildContext context) {
    return TextFormField(
      autofillHints: const [AutofillHints.email],
      controller: controller.txtEmail,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => controller.validateEmail(value!),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: "email".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        prefixIcon: Icon(
          CupertinoIcons.mail,
          color: MYColor.buttons,
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
