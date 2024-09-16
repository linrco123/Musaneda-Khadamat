import 'package:get/get.dart';

class DatePickerController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  
  late DateTime dateTime;
  RxString selectedDate = ''.obs;

  void selectDateTime(DateTime dateTime) {
  //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
  // final String formatted = formatter.format(now);
    selectedDate.value = dateTime.toString().split(' ')[0];
    update();
  }
}
