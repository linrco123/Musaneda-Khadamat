


import 'package:get/get.dart';
import 'package:musaneda/app/modules/hourly_service/mediation/controllers/mediation_controller.dart';

class MediationBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(()=> MediationController());
  }
 }