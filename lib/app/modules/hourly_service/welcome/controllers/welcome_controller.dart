import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/routes/app_pages.dart';

class WelcomeController extends GetxController {
  static WelcomeController get instance => Get.put(WelcomeController());
  @override
  void onInit() {
    super.onInit();
    connectivity().then((value){
      if(value == false){
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
  String greetings() {
    DateTime greeting = DateTime.now();
    if (greeting.isAfter(desiredTime(hour: 16, minutes: 59)) ||
        // greeting.isBefore(desiredTime(hour: 23, minutes: 59)) ||
        greeting.isAtSameMomentAs(desiredTime(hour: 23, minutes: 59))) {
      return 'good_evening'.tr;
    } else if (greeting.isBefore(desiredTime(hour: 11, minutes: 59)) ||
        greeting.isAtSameMomentAs(desiredTime(hour: 11, minutes: 59))) {
      return 'good_morning'.tr;
    } else if (greeting.isAfter(desiredTime(hour: 11, minutes: 59)) ||
        greeting.isBefore(desiredTime(hour: 16, minutes: 59)) ||
        greeting.isAtSameMomentAs(desiredTime(hour: 16, minutes: 59))) {
      return 'good_afternoon'.tr;
    } else {
      return 'good_morning'.tr;
    }
  }

  DateTime desiredTime({int hour = 1, int minutes = 1}) {
    return DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        hour,
        minutes,
        DateTime.now().second,
        DateTime.now().millisecond,
        DateTime.now().microsecond);
  }

  void goToServiceTypeView() {
    Get.toNamed(Routes.SERVICETYPE);
  }
}
