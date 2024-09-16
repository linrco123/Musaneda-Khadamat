

import 'package:get/get.dart';
import 'package:musaneda/app/modules/hourly_service/packages/controllers/packages_controller.dart';
 
class PackagesBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PackagesController>(()=>PackagesController());
  }
  
}