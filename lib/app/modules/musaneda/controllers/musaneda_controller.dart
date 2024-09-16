import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
 import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/home/musaneda_model.dart';
 // ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MusanedaController extends GetxController {
  final Completer<PDFViewController> cTr = Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  var isReady = true.obs;
  MusanedaData? selectedMusanedaItem ;
  late MusanedaData musanedaData ;
  @override
  void onInit() {
    super.onInit();
    selectedMusanedaItem = Get.arguments;
    //  if(Get.previousRoute == Routes.HOME)
    musanedaData = Get.arguments as MusanedaData;
  }

  changeIsReady(bool value) => isReady.value = value;

  String errorMessage = '';

  Future<File> createFileOfPdfUrl(String url) async {
    await EasyLoading.show(status: 'waiting'.tr);
    Completer<File> completer = Completer();
    try {
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      await EasyLoading.dismiss();
      update();
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      throw Exception('Error parsing asset file!');
    }
    update();
    return completer.future;
  }
}
