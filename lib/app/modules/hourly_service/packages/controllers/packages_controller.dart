import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/hourly_service/packages/packages_model.dart';
import 'package:musaneda/app/modules/hourly_service/packages/providers/packages_provider.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/controllers/servicetype_controller.dart';
import 'package:musaneda/app/routes/app_pages.dart';

class PackagesController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getPackages();
  }

  final PackagesProvider _packageProvider = PackagesProvider();
  final serviceTypeController = Get.put(ServiceTypeController());

  RxInt selectedPackage = 0.obs;

  var hourPackages = List<PackageData>.empty(growable: true).obs;

  getPackages() {
    _packageProvider
        .getHourPackages(LanguageController.I.getLocale,
            serviceTypeController.nationality.value)
        .then((value) async {
      for (var hour in value.data as List) {
        hourPackages.add(hour);
      }
      await EasyLoading.dismiss();
    }).catchError((error) async {
      await EasyLoading.dismiss();
    });
  }

  void validatePackageTiming(int packageID) {
    _packageProvider.validatePackageTiming(packageID).then((value) async {
      await EasyLoading.dismiss();
      if (value == 1) {
        selectPackage(packageID);
      }
    }).catchError((error) async {
      await EasyLoading.dismiss();
    });
  }

  void selectPackage(int package) {
    selectedPackage.value = package;
    update();
    Get.toNamed(Routes.DATEPICKER);
    // Future.delayed(const Duration(milliseconds: 500)).then((value) {

    // });
  }
}
