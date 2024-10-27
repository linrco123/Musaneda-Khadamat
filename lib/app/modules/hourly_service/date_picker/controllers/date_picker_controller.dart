import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/hourly_service/date_picker/provider/date_picker_provider.dart';
import 'package:musaneda/app/routes/app_pages.dart';

class DatePickerController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  late DateTime dateTime;
  RxString selectedDate = ''.obs;

  void validatePackageTiming(int packageID) {
    if (selectedDate.value.trim() !=
        DateTime.now().toString().split(' ')[0].trim()) {
      Get.toNamed(Routes.SHOWADDRESS);
    } else {
      DatePickerProvider().validatePackageTiming(packageID).then((value) async {
        await EasyLoading.dismiss();
        if (value == 1) {
          Get.toNamed(Routes.SHOWADDRESS);
        }
      }).catchError((error) async {
        await EasyLoading.dismiss();
      });
    }
  }

  void selectDateTime(DateTime dateTime) {
    //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
    // final String formatted = formatter.format(now);
    selectedDate.value = dateTime.toString().split(' ')[0].trim();
    update();
  }
}
