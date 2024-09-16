


import 'package:get/get.dart';
import 'package:musaneda/app/modules/internet_conn_status/controllers/internet_conn_controller.dart';

class InternetConnBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>InternetConnectionController());
  }
  
}