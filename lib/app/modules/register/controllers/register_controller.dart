import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/app/modules/login/controllers/login_controller.dart';
import 'package:musaneda/config/functions.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../providers/register_provider.dart';

class RegisterController extends GetxController {
  static RegisterController I = Get.put(RegisterController());
  static LoginController loginController = Get.put(LoginController());
  var isProcessing = false.obs;

  final formRegisterKey = GlobalKey<FormState>();

  RxBool obscureText = true.obs;

  TextEditingController txtFullName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtIqama = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  /// OTP Code
  String appSignature = '';
  String otpCode = '';

  set setOtpCode(String? s) {
    otpCode = s!;
  }

  get getSignature => appSignature;

  @override
  void onInit() {
    super.onInit();
    SmsAutoFill().getAppSignature.then((signature) {
      appSignature = signature;
    });
  }

  /// Toggle password visibility
  void toggleObscureText() {
    obscureText.value = !obscureText.value;
    update();
  }

  /// Get Icon for eye icon
  Icon getIcon() {
    return Icon(
      obscureText.value ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,
      color: MYColor.icons,
    );
  }

  /// Validate Full Name
  validateFullName(String value) {
    if (value.isEmpty) {
      return "msg_plz_enter_full_name".tr;
    } else if (value.length < 6) {
      return "msg_plz_name_should_be_more_than_6_char".tr;
    }
    return null;
  }
  /// Validate Phone
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

  /// Validate Iqama
  validateIqama(String value) {
    if (value.isEmpty) {
      return "msg_plz_enter_iqama_number".tr;
    } else if (value.length < 8 || value.length > 11) {
      return 'should_less_11_more_8'.tr;
    }
    // } else if (IqamaValidator().validateSaudiNationalID(value) == false) {
    //   return "msg_plz_enter_correct_iqama_number".tr;
    // }
    return null;
  }

  /// Validate Password
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

  /// Validate Email
  validateEmail(String value) {
    if (value.isEmpty) {
      return "msg_plz_enter_email".tr;
    } else if (!value.contains('@')) {
      return "msg_plz_enter_correct_email".tr;
    }
    return null;
  }

  final box = GetStorage();

  void checkServiceType(){
    loginController.checkServiceType();
  }

  /// register
  register(context) async {
    if (formRegisterKey.currentState!.validate()) {
      try {
        isProcessing(true);
        Map data = {
          "name": txtFullName.text,
          "phone": txtPhone.text.toString(),
          "iqama": txtIqama.text,
          "password": txtPassword.text,
          "device_token": box.read("fcm_token"),
        };

        RegisterProvider().postRegister(data).then(
          (res) {
            isProcessing(false);
            if (res.code! == 1) {
              Map data = {
                "id": res.data!.id,
                "name": res.data!.name,
                "phone": res.data!.phone!,
                "email": res.data!.email,
                "token": res.data!.token,
                "iqama": res.data!.iqama,
                "verified": false,
                "deactivated": false,
              };
              box.write('LOGIN_MODEL', data).then((value) {});
              _showDialog(context);
            }
            //Get.offNamed('/login');
          },
        );
      } catch (e, s) {
        isProcessing(false);
        await Sentry.captureException(e, stackTrace: s);
      }
    }
    update();
  }

  postVerify() async {
    try {
      isProcessing(true);

      Map data = {
        "phone": txtPhone.text,
        "code": otpCode,
      };

      RegisterProvider().postVerify(data).then(
        (res) async {
          if (res == 1) {
            isProcessing(false);
            Get.back();
            checkServiceType();
            //Get.offNamed(Routes.HOME);
            final localData = box.read('LOGIN_MODEL');
            Map data = {
              "id": localData['id'],
              "name": localData['name'],
              "phone": localData['phone'],
              "email": localData['email'],
              "token": localData['token'],
              "iqama": localData['iqama'],
              "verified": true,
              "deactivated": false,
            };
            box.write('LOGIN_MODEL', data).then((value) {});
            await FirebaseMessaging.instance.subscribeToTopic('all');
          }
        },
      );
    } catch (e, s) {
      isProcessing(false);
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  /// resend OTP after 60 seconds
  void resendOtp() {
    Map data = {
      "phone": txtPhone.text.toString(),
    };

    RegisterProvider().postResendOtp(data);
    update();
  }

  void showLogInDialog(context) {
    _showDialog(context);
  }

  /// show dialog when register success
  void _showDialog(context) {
    showDialog(
      context: context,
      anchorPoint: const Offset(0.5, 0.5),
      builder: (context) {
        return Dialog(
          backgroundColor: MYColor.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          insetAnimationCurve: Curves.easeInCirc,
          alignment: Alignment.center,
          child: Container(
            height: 340.0,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "verification_code".tr,
                  style: TextStyle(
                    color: MYColor.white,
                    fontSize: 16,
                    fontFamily: 'cairo_medium',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "enter_the_code_sent_to".tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "enter_the_code_below".tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 250,
                  child: _pinTextField(context),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "did_not_receive_the_code".tr,
                      style: TextStyle(
                        color: MYColor.white,
                        fontSize: 14,
                        fontFamily: 'cairo_extra_light',
                      ),
                    ),
                    TextButton(
                      onPressed: () => resendOtp(),
                      child: Text("resend_code".tr,
                          style: TextStyle(
                            color: MYColor.white,
                            fontSize: 14,
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
    update();
  }

  /// pin text field
  PinFieldAutoFill _pinTextField(BuildContext context) {
    return PinFieldAutoFill(
      keyboardType: TextInputType.number,
      autoFocus: true,
      cursor: Cursor(
        width: 2,
        color: MYColor.buttons,
        enabled: true,
      ),
      codeLength: 4,
      decoration: UnderlineDecoration(
        textStyle: TextStyle(
          fontSize: 28,
          color: MYColor.buttons.withOpacity(0.5),
          fontFamily: 'cairo_semi_bold',
        ),
        colorBuilder: FixedColorBuilder(
          MYColor.buttons,
        ),
        gapSpace: 20,
        lineHeight: 2,
      ),
      currentCode: otpCode,
      smsCodeRegexPattern: r"\d{4}",
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      onCodeChanged: (code) {
        setOtpCode = code;
        if (code!.length == 4) {
          FocusScope.of(context).requestFocus(FocusNode());
          validateOtp();
        }
      },
    );
  }

  /// Validate OTP Code
  validateOtp() {
    if (otpCode.isEmpty) {
      Get.snackbar(
        'error'.tr,
        "msg_plz_enter_otp".tr,
        colorText: Colors.black,
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 800),
        icon: const Icon(
          Icons.error_outline,
          color: Color(0xFFBF202E),
        ),
      );
    } else if (otpCode.length != 4) {
      Get.snackbar(
        'error'.tr,
        "msg_plz_enter_correct_otp".tr,
        colorText: Colors.black,
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 800),
        icon: const Icon(
          Icons.error_outline,
          color: Color(0xFFBF202E),
        ),
      );
    } else {
      postVerify();
    }
  }
}
