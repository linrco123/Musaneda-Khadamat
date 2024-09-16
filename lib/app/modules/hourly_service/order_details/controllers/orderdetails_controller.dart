import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/controllers/servicetype_controller.dart';
import 'package:musaneda/app/routes/app_pages.dart';

class OrderdetailsController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  final serviceTypeController = Get.put(ServiceTypeController());

  void actionMADAButton() {}

  RxBool madaButtonActivenessStatus = true.obs;

  set setMadaButtonActivenessStatus(bool value) {
    madaButtonActivenessStatus.value = value;
  }

  get getMadaButtonActivenessStatus => madaButtonActivenessStatus.value;

  void getDetails() {}

  void payViaMada(BuildContext context,
      {required String date,
      required int package,
      required int paymentOption}) {
    if (getMadaButtonActivenessStatus) {
      serviceTypeController.submitHourlyOrder(
          context, date, package, paymentOption);
      setMadaButtonActivenessStatus = false;
    } else {
      serviceTypeController.showAlertDialogue(context,
          title: 'alert'.tr, content: 'mada_content'.tr, onConfirm: () {
        Get.offAllNamed(Routes.HOME);
      });
    }
  }
}
