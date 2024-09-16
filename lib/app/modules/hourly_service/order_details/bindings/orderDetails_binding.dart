


import 'package:get/get.dart';
import 'package:musaneda/app/modules/hourly_service/order_details/controllers/orderdetails_controller.dart';

class OrderdetailsBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>OrderdetailsController());
  }
  
}