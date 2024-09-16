import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../config/constance.dart';
import '../transaction_id_model.dart';

class UpdateTransactionIdProvider extends GetConnect {
  static UpdateTransactionIdProvider get instance =>
      UpdateTransactionIdProvider.instance;
  GetStorage storage = GetStorage();
  Timer? timer;

  // update transaction id
  Future<TransactionIdModel> updateTransactionId({
    required String transactionId,
    required String orderId,
  }) async {
    try {
      final response = await post(
        "${Constance.apiEndpoint}/update-transaction-id/$orderId",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
        {
          "transaction_id": transactionId,
        },
      );
      
      var statusCode = response.statusCode;
      var data = response.body;
        

      if (data['code'] == 0) {
        return Future.error(0);
      }
      if (response.status.hasError) {
        return Future.error(response.status);
      }

      if (data['code'] == 1) {
        // EasyLoading.dismiss();
        return TransactionIdModel.fromJson(data);
      }

      return TransactionIdModel.fromJson(data);
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
