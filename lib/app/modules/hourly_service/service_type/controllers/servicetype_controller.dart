import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/home/cities_model.dart';
import 'package:musaneda/app/modules/home/name_language_model.dart';
import 'package:musaneda/app/modules/home/nationalities_model.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/models/districts_model.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/models/get_hour_order_model.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/providers/servicetype_provider.dart';
import 'package:musaneda/app/modules/order/views/bank_account/bank_accounts_details_view.dart';
import 'package:musaneda/app/routes/app_pages.dart';
import 'package:musaneda/components/hourly/service_type/oneHour_filter_dialog.dart';
import 'package:musaneda/components/mySnackbar.dart';
import 'package:musaneda/config/constance.dart';
import 'package:musaneda/config/functions.dart';
import 'package:musaneda/config/myColor.dart';

class ServiceTypeController extends GetxController {
  static ServiceTypeController get I => Get.put(ServiceTypeController());
  @override
  void onInit() {
    super.onInit();
    getCities();
    getNationalities();
    getHourOrders();
    workersNumbercontroller = TextEditingController()..text = '1';
  }

  final languageController = LanguageController.I;
  RxDouble packageCost = 0.0.obs;
  set setPackageCost(double cost) {
    packageCost.value = cost;
  }

  get totalPackageCost => packageCost.value * maidsNumber.value;

  var hourServiceAcceptance = false.obs;

  set acceptHourService(bool value) {
    hourServiceAcceptance.value = value;
  }

  //var ContractServiceAcceptance = false.obs;
  void increaseMaidssNumber() {
    maidsNumber.value++;
    workersNumbercontroller.text = maidsNumber.value.toString();
    update();
  }

  void decreaseMaidssNumber() {
    if (maidsNumber.value > 1) {
      maidsNumber.value--;
    }
    workersNumbercontroller.text = maidsNumber.value.toString();
    update();
  }

  void pickAddress(int addressId) {
    selectedLocation.value = addressId;
    update();
    Get.toNamed(Routes.ORDERDETAILS);

    // Future.delayed(const Duration(seconds: 1)).then((value) {
    // });
  }

  //void Function(String)? onChanged
  void onChanged(String number) {
    if (number.isEmpty) {
      maidsNumber.value = 1;
      workersNumbercontroller.text = maidsNumber.value.toString();
    } else {
      if (number.startsWith('1')) {
        String num = number.split('1')[1];

        workersNumbercontroller.text = '';
        workersNumbercontroller.text = num;
        maidsNumber.value = int.parse(num);
      } else {
        workersNumbercontroller.text = '';
        workersNumbercontroller.text = number;
        maidsNumber.value = int.parse(number);
      }
    }
  }

  showAcceptanceDialogue(context) async {
    if (Constance.getToken().isEmpty) {
      showLoginSignupDialogue(Get.context);
    } else {
      if (hourServiceAcceptance.value == false) {
        showAlertDialogue(
          context,
          title: 'alert'.tr,
          content: "acceptance_condition".tr,
          onConfirm: () async {
            acceptHourService = true;
            await EasyLoading.show(status: 'loading'.tr);
            myOneHourFilterDialog(context);
          },
        );
      } else {
        await EasyLoading.show(status: 'loading'.tr);
        myOneHourFilterDialog(context);
      }
    }
  }

  late TextEditingController workersNumbercontroller;
  RxInt nationality = 0.obs;
  RxInt city = 0.obs;
  RxInt district = 0.obs;
  RxInt workingHours = 4.obs;
  RxString shiftType = 'am'.obs;
  RxInt visitsNumber = 0.obs;
  RxInt maidsNumber = 1.obs;
  final selectedLocation = 0.obs;

  void submitHourlyOrder(
      context, String date, int packageId, int paymmentOption) {
    double cost = maidsNumber.value * packageCost.value;
    Map<String, dynamic> map = {
      'from_date': date.toString(),
      'package_id': packageId,
      'user_address_id': selectedLocation.value.toString(),
      'servant_count': maidsNumber.value.toString(),
      'visits': visitsNumber.value.toString(),
      'cost': cost,
      'way_payment': paymmentOption.toString()
    };
    // const PAYMENT_WAY = [
    //  1 => 'CASH',
    //  2 => 'Online',
    //  3 => 'Bank transfer',
    //  4 => 'MADA',
    //      ];

    ServiceTypeProvider().submitHourOrder(map).then((value) {
      EasyLoading.dismiss();
      String orderID = value.data!.order!.id!.toString();
      double totalPrice = double.parse(value.data!.order!.cost!.toString());

      if (paymmentOption == 3) {
        Get.to(() => const BankAccountdetails(), arguments: {
          'orderID': orderID,
          'totalPrice': totalPrice,
          'page': 'hour'
        });
      } else if (paymmentOption == 2) {
        // It is supposed to transition to online payment screen
        //    Get.to(() => const BankAccountdetails(), arguments: {
        //   'orderID': orderID,
        //   'totalPrice': totalPrice,
        //   'page': 'hour'
        // });
        Get.toNamed(Routes.HOURPAYMENT);
      } else if (paymmentOption == 4) {
        showAlertDialogue(context,
            title: 'alert'.tr, content: 'mada_content'.tr, onConfirm: () {
          Get.offAllNamed(Routes.HOME);
        });
      }
    }).catchError((error) {
      EasyLoading.dismiss();
    });
  }

  showAlertDialogue(context, {title, content, void Function()? onConfirm}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shadowColor: MYColor.primary,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          titleTextStyle: TextStyle(color: MYColor.white, fontSize: 27.0),
          content: Text(
            content,
            textAlign: TextAlign.center,
          ),
          contentTextStyle: TextStyle(
              color: MYColor.white,
              fontSize: 17.0,
              fontFamily: 'cairo_regular'),
          backgroundColor: MYColor.secondary,
          clipBehavior: Clip.antiAlias,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                      color: MYColor.primary.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0))),
                  child: TextButton(
                      onPressed: onConfirm,
                      child: Text(
                        'ok'.tr,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            )
          ],
        );
      },
    );
    //  Get.defaultDialog(
    //   backgroundColor: MYColor.secondary,
    //   title: title, //'alert'.tr 'mada_content'.tr
    //   titleStyle: TextStyle(color: MYColor.white),
    //   content: Text(
    //     textAlign: TextAlign.center,
    //     content,
    //     style: TextStyle(
    //         color: MYColor.white,
    //         fontSize: 16.0,
    //         fontFamily: 'cairo_regular'),
    //   ),
    //   contentPadding:
    //       const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
    //   textConfirm: 'ok'.tr,
    //   confirmTextColor: MYColor.white,
    //   buttonColor: MYColor.buttons,
    //   onConfirm: onConfirm,
    // );
  }

  String get getShiftStartingTime =>
      shiftType.value == 'am' ? '08:00' : '12:00';

  set changeWorkingHours(int wHours) {
    workingHours.value = wHours;
    if (wHours == 8) {
      shiftType.value = 'am';
    }
    update();
  }

  void changeShiftType(String shift) {
    shiftType.value = shift;
    update();
  }

  goToHomePage() {
    Get.toNamed(Routes.HOME);
  }

  void validateFilterOptions() {
    if (city.value == 0) {
      mySnackBar(
        title: "warning".tr,
        message: "msg_select_city".tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    } else if (district.value == 0) {
      mySnackBar(
        title: "warning".tr,
        message: "msg_select_district".tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    } else if (nationality.value == 0) {
      mySnackBar(
        title: "warning".tr,
        message: "choose_nationality".tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    } else if (visitsNumber.value == 0) {
      mySnackBar(
        title: "warning".tr,
        message: "choose_visit_number".tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    } else if (maidsNumber.value == 0) {
      mySnackBar(
        title: "warning".tr,
        message: "choose_maid_number".tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    } else {
      Get.back();
      Get.back();
      Get.toNamed(Routes.PACKAGES);
    }
  }

  //nationalities section
  List<NationalitiesData> nationalityList =
      List<NationalitiesData>.empty(growable: true).obs;
  Future<void> getNationalities() async {
    nationalityList.add(
      NationalitiesData(
        id: 0,
        name: NameLanguage(
          ar: "اختر الجنسيه",
          en: "Select Nationality",
        ),
      ),
    );
    isLoading(true);
    ServiceTypeProvider().getNationalities().then((value) {
      for (var data in value.data as List) {
        nationalityList.add(data);
      }
      isLoading(false);
    });

    update();
  }

  set setNationality(setBranch) {
    nationality.value = setBranch;
    update();
  }
  //cities

  var listCities = List<CitiesData>.empty(growable: true).obs;
  RxBool isLoading = false.obs;
  Future<void> getCities() async {
    listCities.add(
      CitiesData(
        id: 0,
        name: NameLanguage(
          ar: "اختر المدينه",
          en: "Select City",
        ),
      ),
    );
    isLoading(true);
    ServiceTypeProvider().getCities().then((value) {
      for (var data in value.data as List) {
        listCities.add(data);
      }
      isLoading(false);
    });

    update();
  }

  set setCity(setCity) {
    city.value = setCity;
    update();
  }

  List<DistrictsData> listDistricts = List<DistrictsData>.empty(growable: true);
   void getDistricts(int cityID)   {
    isLoading(true);
    listDistricts.clear();
    listDistricts.add(
      DistrictsData(
        id: 0,
        title: TitleLang(
          ar: "اختر الحى",
          en: "Select District",
        ),
        latitude: "",
        longitude: "",
        city: 0,
      ),
    );
    ServiceTypeProvider().getDistricts(cityID).then((value) {
      for (var data in value.data as List) {
        listDistricts.add(data);
      }
      isLoading(false);
      update();
    }).catchError((error) async {
      await EasyLoading.dismiss();
    });

   // update();
  }

  set setDistrict(setDistrict) {
    district.value = setDistrict;
    update();
  }

  set setVisitsNumber(int i) {
    visitsNumber.value = i;
    update();
  }

  List<NationalitiesData> visitNumberList = [
    NationalitiesData(
      id: 0,
      name: NameLanguage(
        ar: "اختر عدد الزيارات",
        en: "Select visit numbers",
      ),
    ),
    NationalitiesData(
      id: 1,
      name: NameLanguage(
        ar: "عقد شهرى",
        en: "Monthly Contracts",
      ),
    ),
    NationalitiesData(
      id: 2,
      name: NameLanguage(
        ar: "زيارة واحدة",
        en: "Single Visit",
      ),
    ),
    NationalitiesData(
      id: 3,
      name: NameLanguage(
        ar: "6 أيام فى الإسبوع",
        en: "6 Days Per Week",
      ),
    ),
  ];

  var listHourOrders = List<HourData>.empty(growable: true).obs;
  var page = 1.obs;
  var lastPage = false.obs;

  Future<void> getHourOrders() async {
    isLoading(true);
    ServiceTypeProvider()
        .getHourOrders(page.value, languageController.getLocale)
        .then(
      (value) {
        for (var data in value.data!.data as List) {
          listHourOrders.add(data);
        }
        isLoading(false);
        update();
      },
    ).catchError((error) {
      isLoading(false);
      update();
    });
    update();
  }

  Future<void> getMoreHourOrders() async {
    isLoading(true);
    ServiceTypeProvider()
        .getHourOrders(page.value++, languageController.getLocale)
        .then(
      (value) {
        for (var data in value.data!.data as List) {
          listHourOrders.add(data);
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
