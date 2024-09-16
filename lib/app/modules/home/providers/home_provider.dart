import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/app/modules/home/cities_model.dart';
import 'package:musaneda/app/modules/home/contracts_model.dart';
import 'package:musaneda/app/modules/home/nationalities_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../../../components/mySnackbar.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../musaneda_model.dart';
import '../sliders_model.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends GetConnect {
  final box = GetStorage();

  /// Get all Sliders from api
  Future<Sliders> getSliders() async {
    try {
      final res = await http.get(
        Uri.parse("${Constance.apiEndpoint}/sliders"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );
      final response = jsonDecode(res.body);
      if (response['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't get Sliders",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.statusCode != 200) {
        return Future.error(res.statusCode);
      } else {
        return Sliders.fromJson(response);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Musaneda from api
  Future<Musaneda> getMusaneda(int page) async {
    try {
      final res = await http.get(
        Uri.parse("${Constance.apiEndpoint}/musanedas?page=$page"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );
      if (res.statusCode != 200) {
        return Future.error(res.statusCode);
      } else {
        return Musaneda.fromJson(jsonDecode(res.body));
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Filter Musaneda from api by sending nationalities & age & marital status
  Future<Musaneda> getFilter(
      {required int national,
      required int age,
      required int marital,
      required int page}) async {
    try {
      final queryParams = getRequestParams(page, age, national, marital);
      final res = await http.get(
        Uri.parse("${Constance.apiEndpoint}/filter?$queryParams"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );
       if (jsonDecode(res.body)['code'] == 0) {
        // mySnackBar(
        //   title: "error".tr,
        //   message: "Can't_find".tr,
        //   color: MYColor.warning,
        //   icon: CupertinoIcons.info_circle,
        // );
        return Future.error(res.statusCode);
      }
      if (res.statusCode != 200) {
        return Future.error(res.statusCode);
      } else {
        return Musaneda.fromJson(jsonDecode(res.body));
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  //All three params (age , national , marital) shouldn't be zero one time....
  getRequestParams(int page, int age, int national, int marital) {
    if (age == 0) {
      // age= zero in all cases
      if (marital == 0) {
        return "page=$page&nationality_id=$national";
      } else {
        if (national == 0) {
          return "page=$page&marital_status=$marital";
        } else {
          return "page=$page&nationality_id=$national&marital_status=$marital";
        }
      }
    } else if (national == 0) {
      //&nationality_id = zero in all cases
      if (marital == 0) {
        //marital_status= zero
        return "page=$page&age=$age";
      } else {
        //marital_status != zero
        if (age == 0) {
          return "page=$page&marital_status=$marital";
        } else {
          return "page=$page&age=$age&marital_status=$marital";
        }
      }
    } else if (marital == 0) {
      //marital_status = zero in all cases
      if (age == 0) {
        // age = zero
        return "page=$page&nationality_id=$national";
      } else {
        // age != zero Here
        if (national == 0) {
          return "page=$page&age=$age";
        } else {
          return "page=$page&age=$age&nationality_id=$national";
        }
      }
    }

    return "page=$page&age=$age&nationality_id=$national&marital_status=$marital";
  }

  /// Get all Search Musaneda from api by sending name
  Future<Musaneda> getSearch(keyword) async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/search?name=$keyword",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );
      final response = jsonDecode(res.body) as Map<String, dynamic>;

      if (response['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't_find".tr,
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      // if (res.body['body'] == 1) {
      //   mySnackBar(
      //     title: "success".tr,
      //     message: "correct results",
      //     color: MYColor.warning,
      //     icon: CupertinoIcons.info_circle,
      //   );
      // }
      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Musaneda.fromJson(response['data']);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Contracts from api
  Future<Contracts> getContracts() async {
    try {
      final res = await http.get(
        Uri.parse("${Constance.apiEndpoint}/orders-history"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.getToken()}",
        },
      );
      var response = jsonDecode(res.body);
      if (response['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Sorry Can't fetch contracts",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }
      // if (res.statusCode == 401) {
      //   mySnackBar(
      //     title: "warning".tr,
      //     message: "session_expired_login_again".tr,
      //     color: MYColor.warning,
      //     icon: CupertinoIcons.info_circle,
      //   );
      //   Get.offAllNamed(Routes.LOGIN);
      // }

      if (res.statusCode != 200) {
        return Future.error(res.statusCode);
      } else {
        return Contracts.fromJson(response);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Nationalities from api
  Future<Nationalities> getNationalities() async {
    try {
      final res = await http.get(
        Uri.parse("${Constance.apiEndpoint}/nationalities"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );
      final response = jsonDecode(res.body);
      if (response['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't fetch nationalities",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.statusCode != 200) {
        return Future.error(res.statusCode);
      } else {
        return Nationalities.fromJson(response);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  Future<Nationalities> getContractsNationalities() async {
    try {
      final res = await http.get(
        Uri.parse("${Constance.apiEndpoint}/musaneda_nationality_contracts"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );
      final response = jsonDecode(res.body);
      if (response['code'] == 0) {
        // mySnackBar(
        //   title: "error".tr,
        //   message: "Can't fetch nationalities",
        //   color: MYColor.warning,
        //   icon: CupertinoIcons.info_circle,
        // );
      }

      if (res.statusCode != 200) {
        return Future.error(res.statusCode);
      } else {
        return Nationalities.fromJson(response);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Cities from api
  Future<Cities> getCities() async {
    try {
      final res = await http.get(
        Uri.parse("${Constance.apiEndpoint}/cities"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );
      final response = jsonDecode(res.body);
      if (response['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't fetch cities",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }
      if (res.statusCode != 200) {
        return Future.error(res.statusCode);
      } else {
        return Cities.fromJson(response);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
