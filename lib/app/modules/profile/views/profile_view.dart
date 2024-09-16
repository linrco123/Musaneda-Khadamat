// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/login/controllers/login_controller.dart';
import 'package:musaneda/app/routes/app_pages.dart';
import 'package:musaneda/components/hourly/return_back_btn.dart';
import 'package:musaneda/config/myColor.dart';

import '../../../../components/myCupertinoButton.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final bool isReal;
  const ProfileView({Key? key, required this.isReal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getProfile();
    return GetX(
      init: controller,
      builder: (ctx) {
        return Scaffold(
          appBar: controller.guest.value
              ? AppBar(
                  leading: ReturnButton(color: MYColor.primary, size: 20.0),
                )
              : AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  backgroundColor: MYColor.transparent,
                  title: Text(
                    controller.enabled.value
                        ? "update_profile".tr
                        : "profile".tr,
                    style: TextStyle(
                      color: MYColor.buttons,
                    ),
                  ),
                  centerTitle: true,
                  iconTheme: IconThemeData(
                    color: MYColor.buttons,
                  ),
                  leading: isReal
                      ? IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: MYColor.primary,
                          ),
                          onPressed: () {
                            LoginController.I.logout();
                          },
                        )
                      : ReturnButton(color: MYColor.primary, size: 20.0),
                  actions: [
                    if (!controller.enabled.value)
                      IconButton(
                        onPressed: () {
                          controller.setEnabled = true;
                        },
                        icon: SvgPicture.asset(
                          "assets/images/icon/pencil.svg",
                          width: 20.31,
                          height: 20.31,
                        ),
                      )
                    else
                      IconButton(
                        onPressed: () {
                          controller.setEnabled = false;
                        },
                        icon: const Icon(CupertinoIcons.xmark_rectangle),
                      )
                  ],
                ),
          body: controller.isLoading.value
              ? SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: MYColor.primary,
                      )
                    ],
                  ),
                )
              : Obx(
                  () => controller.guest.value
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'guest'.tr,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: MYColor.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text('have_no_account'.tr,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: MYColor.grey,
                                      fontFamily: 'cairo_regular',
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                  textAlign: TextAlign.center,
                                  "see_personal_data".tr,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: MYColor.grey,
                                      fontFamily: 'cairo_regular',
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10.0),
                              Container(
                                padding: const EdgeInsets.all(0.0),
                                decoration: BoxDecoration(
                                    color: MYColor.secondary.withOpacity(0.6),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0))),
                                child: TextButton(
                                    onPressed: () {
                                      Get.offAllNamed(Routes.LOGIN);
                                    },
                                    child: Text(
                                      'go'.tr,
                                      style: TextStyle(
                                          color: MYColor.primary,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                        )
                      : Form(
                          key: controller.formProfileKey,
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            children: [
                              const SizedBox(height: 40),
                              SvgPicture.asset(
                                "assets/images/drawer/user.svg",
                                color: MYColor.primary,
                                height: 80,
                                width: 80,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'full_name'.tr,
                                style: TextStyle(
                                  color: MYColor.buttons,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _nameTextField(context),
                              const SizedBox(height: 20),
                              Text(
                                'iqama_number'.tr,
                                style: TextStyle(
                                  color: MYColor.buttons,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _iqamaTextField(context),
                              const SizedBox(height: 20),
                              Text(
                                'phone_number'.tr,
                                style: TextStyle(
                                  color: MYColor.buttons,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _phoneTextField(context),
                              const SizedBox(height: 20),
                              Visibility(
                                visible: controller.enabled.value,
                                child: SizedBox(
                                  height: 52,
                                  width: double.infinity,
                                  child: MyCupertinoButton(
                                    btnColor: MYColor.buttons,
                                    txtColor: MYColor.btnTxtColor,
                                    text: "save_updates".tr,
                                    fun: () {
                                      controller.postProfile(isReal:isReal);
                                    },
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !controller.enabled.value,
                                child: SizedBox(
                                  height: 52,
                                  width: double.infinity,
                                  child: MyCupertinoButton(
                                    btnColor: MYColor.buttons,
                                    txtColor: MYColor.btnTxtColor,
                                    text: "remove_account".tr,
                                    fun: () {
                                      controller.removeAccount();
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                ),
        );
      },
    );
  }

  /// full name text field
  TextFormField _nameTextField(BuildContext context) {
    return TextFormField(
      enabled: controller.enabled.value,
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
          color: MYColor.primary,
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
      enabled: false,
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
          color: MYColor.primary,
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
      enabled: controller.enabled.value,
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
          color: MYColor.primary,
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
      enabled: false,
      autofillHints: const [AutofillHints.telephoneNumber],
      controller: controller.txtPhone,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
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
                  color: MYColor.primary,
                ),
                const SizedBox(width: 10),
                Text(
                  "phone_number".tr,
                  style: TextStyle(
                    color: MYColor.buttons,
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
