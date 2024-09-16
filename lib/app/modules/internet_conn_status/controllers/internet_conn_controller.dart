import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/internet_conn_status/views/internet_connection.dart';
import 'package:musaneda/app/routes/app_pages.dart';

class InternetConnectionController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    streamInternetListener = Connectivity();
    listenToConnection();
  }

  late Connectivity streamInternetListener;
  late StreamSubscription<ConnectivityResult> streamSubscription;
  void listenToConnection() {
   streamSubscription =  streamInternetListener.onConnectivityChanged.listen(
      (event) async {
        checkConnectivityToInternet(connectivityResult:event);
      },
    );
  }

  void checkConnectivityToInternet(
      {ConnectivityResult? connectivityResult}) async {
    bool result = await checkconnectivity();
    if (result == false) {
      if (Get.currentRoute != Routes.INTERNETCONNECTION) {
        Get.to(const InternetConnectionView());
      }
    } else {
      Get.back();
    }
  }

  Future<bool> checkconnectivity() async {
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    streamSubscription.cancel();
  }

  
}
