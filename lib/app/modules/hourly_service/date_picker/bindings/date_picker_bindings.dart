import 'package:get/get.dart';
import 'package:musaneda/app/modules/hourly_service/date_picker/controllers/date_picker_controller.dart';

class DatePickerBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DatePickerController());
  }
}
