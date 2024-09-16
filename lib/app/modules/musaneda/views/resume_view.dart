import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:musaneda/components/hourly/return_back_btn.dart';

import '../../../../config/myColor.dart';
import '../controllers/musaneda_controller.dart';

class ResumeView extends GetView<MusanedaController> {
  const ResumeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        title: Text('resume'.tr),
        centerTitle: true,
        leading: ReturnButton(color: MYColor.white, size: 20.0),
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) => PDFView(
          filePath: Get.arguments,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: true,
          pageSnap: true,
          defaultPage: controller.currentPage!,
          fitPolicy: FitPolicy.BOTH,
          preventLinkNavigation: false,
          onRender: (p) {
            controller.pages = p;
            controller.changeIsReady(false);
          },
          onError: (error) {
            controller.errorMessage = error.toString();
            if (kDebugMode) {
                
            }
          },
          onPageError: (page, error) {
            controller.errorMessage = '$page: ${error.toString()}';
            if (kDebugMode) {
                
            }
          },
          onViewCreated: (pdfCtrl) {
            controller.cTr.complete(pdfCtrl);
          },
          onLinkHandler: (String? uri) {
            if (kDebugMode) {
                
            }
          },
          onPageChanged: (int? page, int? total) {
            if (kDebugMode) {
                
            }
            controller.currentPage = page;
          },
        ),
      ),
    );
  }
}
