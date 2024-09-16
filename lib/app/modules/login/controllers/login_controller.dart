import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/app/modules/home/name_language_model.dart';
import 'package:musaneda/app/modules/register/controllers/register_controller.dart';
import 'package:musaneda/app/routes/app_pages.dart';
import 'package:musaneda/components/mySnackbar.dart';
import 'package:musaneda/config/functions.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../../home/nationalities_model.dart';
import '../../profile/controllers/profile_controller.dart';
import '../providers/login_provider.dart';

class LoginController extends GetxController {
  static LoginController get I => Get.put(LoginController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSystemType();
    connectivity().then((value) {
      if (value == false) {
        Get.toNamed(Routes.INTERNETCONNECTION);
      }
    });
  }

  Future<bool> connectivity() async {
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  RxInt systemType = 1.obs;
  var isProcessing = false.obs;
  final box = GetStorage();
  final formLoginKey = GlobalKey<FormState>();

  RxBool obscureText = true.obs;

  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  RxInt selectedLanguage = 0.obs;
  List<NationalitiesData> languageList = [
    NationalitiesData(
      id: 0,
      name: NameLanguage(
        ar: "اللغة",
        en: "Language",
      ),
    ),
    NationalitiesData(
      id: 1,
      name: NameLanguage(
        ar: "عربى",
        en: "Arabic",
      ),
    ),
    NationalitiesData(
      id: 2,
      name: NameLanguage(
        ar: "انجليزى",
        en: "English",
      ),
    ),
  ];

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
    update();
  }

  Icon getIcon() {
    return Icon(
      obscureText.value ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,
      color: MYColor.icons,
    );
  }

  validatePhone(String value) {
    final regExp = RegExp(
      Constance.phoneRegExp,
      caseSensitive: false,
      multiLine: false,
    );
    String? normalizedValue;
    if (containsArabicNumerals(value)) {
      normalizedValue = normalizeArabicNumbers(value);
      txtPhone.text = normalizedValue;
    }

    if (value.isEmpty) {
      return "msg_plz_enter_phone".tr;
    } else if (!regExp.hasMatch(normalizedValue ?? value)) {
      return "msg_plz_enter_correct_phone".tr;
    }
    return null;
  }

  validatePassword(String value) {
    if (containsArabicNumerals(value)) {
      value = normalizeArabicNumbers(value);
      txtPassword.text = value;
    }

    if (value.isEmpty) {
      return "msg_plz_enter_password".tr;
    } else if (value.length < 6) {
      return "msg_plz_enter_at_least_6_char".tr;
    }
    return null;
  }

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: Constance.technicalSupport_phone.toString(),
    );
    await launchUrl(launchUri);
  }

  showAlertDialogue({title, content, void Function()? onConfirm}) =>
      Get.defaultDialog(
        backgroundColor: MYColor.secondary,
        title: title, //'alert'.tr 'mada_content'.tr
        titleStyle: TextStyle(color: MYColor.white),
        content: Text(
          textAlign: TextAlign.center,
          content,
          style: TextStyle(
              color: MYColor.white,
              fontSize: 16.0,
              fontFamily: 'cairo_regular'),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        textConfirm: 'call'.tr,
        confirmTextColor: MYColor.white,
        buttonColor: MYColor.buttons,
        onConfirm: onConfirm,
      );
  Future<void> login() async {
    try {
      if (formLoginKey.currentState!.validate()) {
        Map data = {
          "phone": txtPhone.text,
          "password": txtPassword.text,
          "device_token": box.read("fcm_token"),
        };

        log(data.toString());
        isProcessing(true);
        LoginProvider().postLogin(data).then(
          (res) async {
            if (res.code == 0 && res.message! == "Verify account") {
              // data should be stored here
              RegisterController.I.txtPhone.text =
                  LoginController.I.txtPhone.text;
              RegisterController.I.showLogInDialog(Get.context);
            }
            if (res.code == 0 && res.message == "Account DeActivated") {
              showAlertDialogue(
                  title: 'warning'.tr,
                  content: 'deactivate_content'.tr,
                  onConfirm: () {
                    Get.back();
                    makePhoneCall();
                  });
            }
            if (res.code == 1) {
              Map data = {
                "id": res.data!.id,
                "name": res.data!.name,
                "phone": res.data!.phone!,
                "email": res.data!.email,
                "token": res.data!.token,
                "iqama": res.data!.iqama,
                "verified": true,
                "deactivated": false,
              };

              box.write('LOGIN_MODEL', data).then((value) {
                getName();
              });

              ProfileController.I.getProfile();

              isProcessing(false);

              LoginProvider().lookupUserCountry().then(
                (value) {
                  if (value == "SA") {
                    box.write('SA', true);
                  }
                  if (systemType.value == 1) {
                    Get.offAllNamed(Routes.HOME);
                  } else {
                    Get.offAllNamed(Routes.MAIN_HOME_PAGE);
                  }
                },
              );
              FirebaseMessaging.instance.subscribeToTopic('all');
            }
          },
        );
      }
    } catch (e, s) {
      log(e.toString(), name: 'LoginController => logins()');
      isProcessing.value = false;

      await Sentry.captureException(e, stackTrace: s);
    }
  }

// {
//     "code": 1,
//     "environment": 1,
//     "msg": "production"
// }
  void getSystemType() {
    LoginProvider().getSystemType().then((value) {
      systemType.value = value;
    });
  }

  Future<void> removeAccount() async {
    try {
      Map data = {};
      LoginProvider().removeAccount(data).then(
        (res) {
          if (res.code == 1) {
            box.remove('LOGIN_MODEL');
            Get.offAllNamed(Routes.LOGIN);
          }
        },
      );
    } catch (e, s) {
      log(e.toString(), name: 'LoginController => removeAccount()');
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  bool isSA() {
    if (box.hasData('SA')) {
      log(
        "SA: ${box.read('SA')}",
        name: "IS_SA",
      );
      return true;
    }
    LoginProvider().lookupUserCountry().then(
      (value) {
        if (value == "SA") {
          box.write('SA', true);
          return true;
        } else {
          box.remove('SA');
          return false;
        }
      },
    );

    return false;
  }

  bool isAuth() {
    if (box.hasData('LOGIN_MODEL')) {
      return true;
    }
    return false;
  }

  String? getName() {
    if (box.hasData('LOGIN_MODEL')) {
      var jsonString = box.read('LOGIN_MODEL');
      return jsonString['name'];
    }

    return "";
  }

  logout() async {
    box.remove('LOGIN_MODEL');
    box.remove('SA');
    mySnackBar(
      title: "success".tr,
      message: "msg_logout_success".tr,
      color: MYColor.success,
      icon: CupertinoIcons.check_mark_circled,
    );
    Future.delayed(const Duration(seconds: 1)).then((_) {
      Get.offAllNamed(Routes.LOGIN);
    });
    update();
  }

  void checkServiceType() {
    if (systemType.value == 1) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.MAIN_HOME_PAGE);
    }
  }
}
