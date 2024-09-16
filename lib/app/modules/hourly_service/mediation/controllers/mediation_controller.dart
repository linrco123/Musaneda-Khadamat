import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/home/name_language_model.dart';
import 'package:musaneda/app/modules/home/nationalities_model.dart';
import 'package:musaneda/app/modules/hourly_service/mediation/model/get_mediation_model.dart';
import 'package:musaneda/app/modules/hourly_service/mediation/providers/mediation_provider.dart';
import 'package:musaneda/components/mySnackbar.dart';
import 'package:musaneda/config/myColor.dart';

class MediationController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNationalities();
    getMediations();
    cardNumberController.text = '';
  }
  var languageController = LanguageController.I;
  var formKey = GlobalKey<FormState>();
  var cardNumberController = TextEditingController();
  var isLoading = false.obs;

  String? validateCardNumber(String? cardNumber) {
    if (cardNumber!.isEmpty) {
      return 'visa_number_card_required'.tr;
    } else if (cardNumber.length != 10) {
      return 'invalid_visa_number'.tr;
    }
    return null;
  }

  List<NationalitiesData> nationalityList =
      List<NationalitiesData>.empty(growable: true).obs;
  RxInt nationality = 0.obs;
  Future<void> getNationalities() async {
    nationalityList.add(
      NationalitiesData(
        id: 0,
        name: NameLanguage(
          ar: "الجنسيه",
          en: "Nationality",
        ),
      ),
    );
    isLoading(true);
    MediationProvider().getNationalities().then((value) {
      for (var data in value.data as List) {
        nationalityList.add(data);
      }
      isLoading(false);
      update();
    });

   // update();
  }

  set setNationality(setBranch) {
    nationality.value = setBranch;
    update();
  }

  set setJob(int value) {
    selectedJob.value = value;
    update();
  }

  void sendMediationOptions() {
    if (nationality.value == 0) {
      mySnackBar(
        title: "warning".tr,
        message: "choose_nationality".tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    } else if (selectedJob.value == 0) {
      mySnackBar(
        title: "warning".tr,
        message: "choose_job".tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    } else if (selectedExperience.value == 0) {
      mySnackBar(
        title: "warning".tr,
        message: "choose_experience".tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    } else {
      Map data = {};
      if (cardNumberController.text.isEmpty) {
        data = {
          "job": selectedJob.value,
          "experience": selectedExperience.value,
          "country_id": nationality.value,
        };
      } else {
        data = {
          "job": selectedJob.value,
          "experience": selectedExperience.value,
          "country_id": nationality.value,
          "visa_number": cardNumberController.text
        };
      }
      MediationProvider().submitMediation(data).then((value) async {
        await EasyLoading.dismiss();

        cardNumberController.text = '';
        nationality.value = 0;
        selectedExperience.value = 0;
        selectedJob.value = 0;
       // update();
       Navigator.of(Get.context!).pop();
       }).catchError((error) async {
        await EasyLoading.dismiss();
      });
      // }
    }
  }

  RxInt selectedJob = 0.obs;
  List<NationalitiesData> jobsList = [
    NationalitiesData(
      id: 0,
      name: NameLanguage(
        ar: "الوظيفة",
        en: "Job",
      ),
    ),
    NationalitiesData(
      id: 1,
      name: NameLanguage(
        ar: "عاملة منزلية مقيمة ",
        en: " Housemaid cleaning services ",
      ),
    ),
    NationalitiesData(
      id: 2,
      name: NameLanguage(
        ar: "مساعدة شخصية",
        en: "Personal assistant",
      ),
    ),
    NationalitiesData(
      id: 3,
      name: NameLanguage(
        ar: "سائق خاص ",
        en: "Private chauffer",
      ),
    ),
    NationalitiesData(
      id: 4,
      name: NameLanguage(
        ar: "عامل منزلى",
        en: "House cleaner",
      ),
    ),
  ];
  set setExperience(int value) {
    selectedExperience.value = value;
    update();
  }

  RxInt selectedExperience = 0.obs;
  List<NationalitiesData> experienceList = [
    NationalitiesData(
      id: 0,
      name: NameLanguage(
        ar: "الخبرة",
        en: "ُExperience",
      ),
    ),
    NationalitiesData(
      id: 1,
      name: NameLanguage(
        ar: "بخبرة",
        en: "With experience",
      ),
    ),
    NationalitiesData(
      id: 2,
      name: NameLanguage(
        ar: "بدون خبرة",
        en: "Without experience",
      ),
    ),
  ];

   var listmediations = List<MediationData>.empty(growable: true).obs;
  var page = 1.obs;
  var lastPage = false.obs;

  Future<void> getMediations() async {
    isLoading(true);
    MediationProvider().getMediations(page.value , languageController.getLocale).then(
      (value) {
        for (var data in value.data!.data! as List) {
          listmediations.add(data);
        }
        isLoading(false);
        update();
      },
    );
    update();
  }

  Future<void> getMoreMediation() async {
    isLoading(true);
    MediationProvider().getMediations(page.value++ , languageController.getLocale).then(
      (value) {
        for (var data in value.data!.data as List) {
          listmediations.add(data);
        }
        isLoading(false);
        if (value.data!.total! <= page.value) {
          lastPage(true);
        }
        update();
      },
    );
    update();
  }
}
