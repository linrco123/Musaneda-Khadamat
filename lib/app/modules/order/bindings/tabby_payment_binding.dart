import 'package:get/get.dart';

import '../controllers/tabby_stc_controllers/tabby_controller.dart';



class TabbyPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabbyPaymentController>(
          () => TabbyPaymentController(),
    );
  }
}