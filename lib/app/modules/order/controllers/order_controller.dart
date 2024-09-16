import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/app/modules/home/musaneda_model.dart';
import 'package:musaneda/app/modules/order/providers/order_provider.dart';
import 'package:musaneda/app/modules/order/providers/packages_provider.dart';
import 'package:musaneda/components/mySnackbar.dart';
import 'package:musaneda/components/myWarningDialog.dart';
import 'package:musaneda/config/myColor.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../../locations/locations_model.dart';
import '../../locations/providers/locations_provider.dart';
import '../branches_model.dart';
import '../order_model.dart';
import '../packages_model.dart';
import '../payment_method.dart';

class OrderController extends GetxController {
  static OrderController get I => Get.put(OrderController());
  static const bool isDev = bool.fromEnvironment('DEV');

  @override
  void onInit() {
    getBranches();
    if (Get.previousRoute == Routes.MUSANEDA) {
      MusanedaData musanedaData = Get.arguments;
      setMusanedaID = musanedaData;
      getPackages(theNationalID: musanedaData.nationality!.id);
    }
    getLocations();
    setMerchantTransactionID();
    super.onInit();
  }

  late String orderID;
  late OrderModel ordermodel;
  PageController pageController = PageController(initialPage: 0);

  late PackagesData packagesData;

  //final pay = false.obs;
  final isLoading = false.obs;
  final rentEnded = false.obs;
  final location = "".obs;

  final currentStep = 1.obs;
  final selectedCity = 0.obs;
  final selectedBranch = 0.obs;
  final selectedPayment = 0.obs;
  final selectedPackage = 0.obs;
  final selectedLocation = 0.obs;
  final listPackages = List<PackagesData>.empty(growable: true).obs;
  final listLocations = List<LocationsData>.empty(growable: true).obs;
  final listBranches = List<BranchesData>.empty(growable: true).obs;

  final box = GetStorage();

  set setIsChecked(bool setIsChecked) {
    rentEnded.value = setIsChecked;
  }

  set setPayment(int pay) {
    selectedPayment.value = pay;
    update();
  }

  set setPackage(PackagesData setPackage) {
    packagesData = setPackage;
    selectedPackage.value = packagesData.id!;
    update();
  }

  set setCity(setCity) {
    selectedCity.value = setCity;
    update();
  }

  set setLocation(setLocation) {
    selectedLocation.value = setLocation;
    update();
  }

  set setLocationForPayment(setLocation) {
    location.value = setLocation;
    update();
  }

  set setBranch(setBranch) {
    selectedBranch.value = setBranch;
    update();
  }

  set setUuid(String uuid) => uuid = uuid;

  DateTime get expiryDate => DateTime.now().add(const Duration(hours: 24));

  DateTime get timestamp => DateTime.now();

  String get addressForPayment => listLocations
      .where((element) => element.id == selectedLocation.value)
      .first
      .address!;

  String get getLocation => location.value;

  String get cityForPayment => listLocations
      .where((element) => element.id == selectedLocation.value)
      .first
      .city!;

  String get getUserName =>
      box.hasData('LOGIN_MODEL') ? box.read('LOGIN_MODEL')['name'] : '';

  String get getUserId => box.hasData('LOGIN_MODEL')
      ? box.read('LOGIN_MODEL')['id'].toString()
      : '';

  String get getAddress =>
      addressForPayment.isEmpty ? getLocation : addressForPayment;

  RxInt paymentMethod = 10.obs;

  changePaymentMethod(int i) {
    paymentMethod.value = i;
    paymentBranch.value = false;
    tabbyOption.value = false;
    paymentBank.value = false;
    update();
  }

  List<PaymentMethod> paymentMethods = [
    PaymentMethod(
        'assets/images/VISA.svg',
        'credit_card_method'
            .tr), //'credit card' 'Pay with MADA card ' 'Pay with STC pay'
    PaymentMethod('assets/images/MADA.svg', 'Pay_mada'.tr),
    PaymentMethod('assets/images/APPLEPAY.svg', 'pay with'),
    PaymentMethod('assets/images/stc.jpeg', 'Pay_stc'.tr), //stcpay
    //PaymentMethod('assets/images/tabby.png', 'Pay with STC pay', null),
  ];

  List<PaymentMethod> fakePaymentMethods = [
    PaymentMethod('assets/images/VISA.svg', 'credit_card_method'.tr),
    PaymentMethod('assets/images/MADA.svg', 'Pay_mada'.tr),
    PaymentMethod('assets/images/APPLEPAY.svg', 'pay with'),
  ];

  RxBool tabbyOption = false.obs;

  RxBool paymentBranch = false.obs;
  RxBool paymentBank = false.obs;

  changepaymentBranchOption() {
    paymentBranch.value = !paymentBranch.value;
    tabbyOption.value = false;
    paymentBank.value = false;
    paymentMethod.value = 10;
    update();
  }

  changepaymentBankOption() {
    paymentBank.value = !paymentBank.value;
    paymentBranch.value = false;
    tabbyOption.value = false;
    paymentMethod.value = 10;
    update();
  }

  changeTabbyOption() {
    tabbyOption.value = !tabbyOption.value;
    paymentMethod.value = 10;
    paymentBranch.value = false;
    paymentBank.value = false;
    update();
  }

  void payInBranch() {
    OrderProvider().payInBranch({"order_id": orderID}).then((value) {
      //code of success
    }).catchError((error) {
      //code of failure
    });
  }

  Future<void> increment() async {
    if (currentStep.value == 3 &&
        (HomeController.I.listActive.isNotEmpty ||
            HomeController.I.listPending.isNotEmpty)) {
      //
      mySnackBar(
        title: "error".tr,
        message: "you_have_unexpired_contract".tr,
        color: MYColor.sadad,
        icon: CupertinoIcons.info_circle,
      );
    } else {
      if (currentStep.value < 4) {
        if (selectedCity.value == 0) {
          mySnackBar(
            title: "error".tr,
            message: "msg_select_city".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        } else if (selectedLocation.value == 0) {
          mySnackBar(
            title: "error".tr,
            message: "msg_select_location".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        } else if (selectedBranch.value == 0) {
          mySnackBar(
            title: "error".tr,
            message: "msg_select_branch".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        } else if (currentStep.value == 2 && selectedPackage.value == 0) {
          mySnackBar(
            title: "error".tr,
            message: "msg_select_package".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        } else {
          if (currentStep.value == 3) {
            await checkOrder(isDone: true);
          } else {
            currentStep.value++;
          }
        }
      }
    }
    update();
  }

  Future<void> decrement() async {
    //setPayment = 0;
    if (currentStep.value > 1) {
      currentStep.value--;
    }
    update();
  }

  Future<void> getPackages({required theNationalID}) async {
    isLoading(true);
    PackagesProvider().getPackages(theNationalID: theNationalID).then((value) {
      for (var data in value.data as List) {
        listPackages.add(data);
      }
      isLoading(false);
    });

    update();
  }

  Future<void> getLocations() async {
    listLocations.clear();
    listLocations.add(
      LocationsData(
        id: 0,
        title: "create_new_location".tr,
        city: "".tr,
        country: "".tr,
        address: "".tr,
        notes: "".tr,
      ),
    );

    isLoading(true);
    LocationsProvider().getLocations().then((value) {
      for (var data in value.data as List) {
        listLocations.add(data);
      }
      isLoading(false);
    });

    update();
  }

  Future<void> getBranches() async {
    listBranches.add(
      BranchesData(
        id: 0,
        name: NameLanguage(
          ar: "إختر الفرع".tr,
          en: "Select Branch".tr,
        ),
      ),
    );

    PackagesProvider().getBranches().then((value) {
      // listBranches.clear();
      for (var data in value.data as List) {
        listBranches.add(data);
      }
    });

    update();
  }

  final uuid = const Uuid();

  String merchantTransactionID = '';

  setMerchantTransactionID() {
    merchantTransactionID = uuid.v4();
    update();
  }

  String get getMerchantTransactionID => merchantTransactionID;

  Future<void> onSadadPay({required context, required musanedaID}) async {
    try {
      Map data = {
        "AmountDue": packagesData.total,
        "UUID": getMerchantTransactionID,
        "musaneda_id": musanedaID,
        "package_id": packagesData.id,
        "city_id": selectedCity.value,
        "location_id": selectedLocation.value,
        "branch_id": selectedBranch.value,
        "transfer": rentEnded.value ? 1 : 0,
        "merchant_transaction_id": getMerchantTransactionID,
      };

      log(data.toString(), name: "sadad_data");
      OrderProvider().createSingleBill(data).then((value) {
        if (value.status.code == 0 && value.status.description == "Success") {
          myWarningDialog(
            title: "sadad_payment_success".tr,
            content: "${"sadad_payment_success_msg".tr}   ${value.sadadNumber}",
            confirm: "copy".tr,
            cancel: "done".tr,
            funConfirm: () {
              Clipboard.setData(
                ClipboardData(text: value.sadadNumber),
              );
              Get.offAllNamed(Routes.HOME);
            },
            funCancel: () {
              Get.offAllNamed(Routes.HOME);
            },
            funWillPop: () {
              Get.offAllNamed(Routes.HOME);
            },
          );
        }
      });
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      log(e.toString(), name: "sadad_exception");
    }
  }

  int musanedaID = 0;

  set setMusanedaID(MusanedaData musaneda) {
    //getPackages(theNationalID: musaneda.nationality!.id);
    musanedaID = musaneda.id!;
    update();
  }

  Future<void> checkOrder({required isDone}) async {
    if (isDone) {
      Map data = {
        "musaneda_id": musanedaID,
        "package_id": packagesData.id,
        "city_id": selectedCity.value,
        "location_id": selectedLocation.value,
        "branch_id": selectedBranch.value,
        "transfer": rentEnded.value ? 1 : 0,
        "merchant_transaction_id": OrderController.I.merchantTransactionID,
      };
      OrderProvider().postOrder(data).then((value) async {
        if (value.code == 1) {
          OrderController.I.orderID = value.data!.orderId.toString();
          await EasyLoading.dismiss();
          await Future.delayed(const Duration(seconds: 1)).then((value) {
            currentStep.value++;
          });
          update();
        }
      }).catchError((error) async {
        mySnackBar(
          title: "alert".tr,
          message: "try_again".tr,
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
        await EasyLoading.dismiss();
      });
    } else {
      mySnackBar(
        title: "warning".tr,
        message: "please_select_payment_method".tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    }

    update();
  }
}
