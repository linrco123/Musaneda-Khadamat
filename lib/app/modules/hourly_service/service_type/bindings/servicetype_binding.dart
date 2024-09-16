

import 'package:get/get.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/controllers/servicetype_controller.dart';

class ServiceTypeBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ServiceTypeController());
  }
  
}