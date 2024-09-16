import 'package:get/get.dart';
import 'package:musaneda/app/modules/hourly_service/welcome/controllers/welcome_controller.dart';

class WelcomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(
      () => WelcomeController(),
    );
  }
}
