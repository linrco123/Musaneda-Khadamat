import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/order/branches_model.dart';
import 'package:musaneda/components/mySnackbar.dart';
import 'package:musaneda/config/myColor.dart';

import '../../../../config/constance.dart';
import '../packages_model.dart';
import 'package:http/http.dart'as http;

class PackagesProvider extends GetConnect {
  Future<Packages> getPackages({required theNationalID}) async {
    try {
      final res = await get(
         "${Constance.apiEndpoint}/packages/$theNationalID",
        headers: {
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.statusCode != 200) {
        Pretty.instance.logger.d({"res.body": res.body});
      }

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "عفوا",
          message: "الرجاء إدخال الاسم",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Packages.fromJson(res.body);
      }
    } catch (exception) {
      Pretty.instance.logger.e(exception);
      return Future.error(exception.toString());
    }
  }

  Future<Branches> getBranches() async {
    try {
      final res = await http.get(Uri.parse("${Constance.apiEndpoint}/branches"));

      Pretty.instance.logger.d({"branches": res.body});

      if (res.statusCode !=200) {
        return Future.error(res.statusCode);
      } else {
        return Branches.fromJson(jsonDecode(res.body));
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
