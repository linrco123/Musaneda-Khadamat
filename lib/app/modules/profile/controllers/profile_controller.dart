import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/app/modules/profile/profile_model.dart';
import 'package:musaneda/app/modules/profile/providers/profile_provider.dart';
import 'package:musaneda/app/routes/app_pages.dart';

import '../../../../config/constance.dart';
import '../../../data/iqama_validator.dart';

class ProfileController extends GetxController {
  static ProfileController get I => Get.put(ProfileController());
  final isProcessing = false.obs;

  final formProfileKey = GlobalKey<FormState>();

  TextEditingController txtFullName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtIqama = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  final enabled = false.obs;

  set setEnabled(bool setEnabled) {
    enabled.value = setEnabled;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
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
    if (value.isEmpty) {
      return "msg_plz_enter_phone".tr;
    } else if (!regExp.hasMatch(value)) {
      return "msg_plz_enter_correct_phone".tr;
    }
    return null;
  }

  /// Validate Iqama
  validateIqama(String value) {
    if (value.isEmpty) {
      return "msg_plz_enter_iqama_number".tr;
    } else if (IqamaValidator().validateSaudiNationalID(value) == false) {
      return "msg_plz_enter_correct_iqama_number".tr;
    }
    return null;
  }

  /// Validate Email
  validateEmail(String value) {
    if (value.isEmpty) {
      return "msg_plz_enter_email".tr;
    } else if (!GetUtils.isEmail(value)) {
      return "msg_plz_enter_correct_email".tr;
    }
    return null;
  }

  var guest = false.obs;
  ProfileData profile = ProfileData();

  ProfileData get getProfileData => profile;
  final isLoading = false.obs;
  void getProfile() async {
    isLoading.value = true;
    ProfileProvider().getProfile().then((value) {
      profile = ProfileData(
        id: value.data!.id,
        name: value.data?.name,
        phone: value.data?.phone!,
        iqama: value.data?.iqama,
        email: value.data?.email,
        emailVerifiedAt: value.data?.emailVerifiedAt,
        createdAt: value.data?.createdAt,
        updatedAt: value.data?.updatedAt,
      );
      txtFullName.text = profile.name!;
      txtPhone.text = profile.phone!;
      txtIqama.text = profile.iqama!;
      txtEmail.text = profile.email!;
      guest.value = false;
      isLoading.value = false;
    }).catchError((error) {
      guest.value = true;
      isLoading.value = false;

      update();
    });

    update();
  }

  final box = GetStorage();
  postProfile({required bool isReal}) async {
    if (formProfileKey.currentState!.validate()) {
      isProcessing.value = true;
      Map data = {
        "name": txtFullName.text,
        "phone": txtPhone.text,
        "iqama": txtIqama.text,
      };
      ProfileProvider().postProfile(data).then((value) {
        Map localData = box.read('LOGIN_MODEL') as Map;
        Map data = {
          "id": localData['id'],
          "name": txtFullName.text,
          "phone": localData['phone'],
          "email": txtEmail.text,
          "token": localData['token'],
          "iqama": localData['iqama'],
          "verified": true
        };

        box.write('LOGIN_MODEL', data).then((value) {
          getProfile();
        });

        isProcessing.value = false;
        setEnabled = false;
        // if (!isReal) {
        //   Get.offNamed(Routes.HOME);
        // } else {}

        getProfile();
      });
    }
    update();
  }

  Future<void> removeAccount() async {
    ProfileProvider().removeAccount().then((value) {
      if (value == 1) {
        Get.offAllNamed(Routes.LOGIN);
        final localData = box.read('LOGIN_MODEL');
        Map data = {
          "id": localData['id'],
          "name": localData['name'],
          "phone": localData['phone'],
          "email": localData['email'],
          "token": localData['token'],
          "iqama": localData['iqama'],
          "verified": true,
          "deactivated": true,
        };
        box.write('LOGIN_MODEL', data).then((value) {});
      }
    });
  }
}
