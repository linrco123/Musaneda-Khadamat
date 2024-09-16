// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/components/hourly/return_back_btn.dart';
import 'package:musaneda/components/myCupertinoButton.dart';
import 'package:musaneda/config/myColor.dart';

import '../../../../components/myComplaintCard.dart';
import '../controllers/complaint_controller.dart';
import 'create_complaint_view.dart';

class ComplaintView extends GetView<ComplaintController> {
  const ComplaintView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        title: Text('tickets'.tr),
        centerTitle: true,
        leading: ReturnButton(color: MYColor.white, size: 20.0),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const CreateComplaintView());
            },
            icon: SvgPicture.asset(
              'assets/images/icon/plus.svg',
              color: MYColor.white,
              height: 20.31,
              width: 19.5,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: 40,
                width: Get.width,
                decoration: BoxDecoration(
                  color: MYColor.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
            child: GetX(
              init: controller,
              builder: (ctx) {
                return controller.listComplaints.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/icon/no_result.svg",
                              height: 134.36,
                              width: 100,
                              color: MYColor.primary,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "there_are_no_results".tr,
                              style: TextStyle(
                                fontSize: 16,
                                color: MYColor.grey,
                                fontFamily: 'cairo_regular',
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              height: 50,
                              width: 166,
                              child: MyCupertinoButton(
                                fun: () {
                                  Get.to(()=>const CreateComplaintView());
                                },
                                text: "add_ticket".tr,
                                btnColor: MYColor.buttons,
                                txtColor: MYColor.btnTxtColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.listComplaints.length,
                        itemBuilder: (ctx, i) {
                          return MyComplaintCard(
                            title: controller.listComplaints[i].title!,
                            // status: controller.listHigh[i].status!,
                            status: i % 2 == 0 ? "open" : "closed",
                            contractID: controller
                                .listComplaints[i].contract!.id
                                .toString(),
                            type: controller.listComplaints[i].type == 1
                                ? "complaint".tr
                                : controller.listComplaints[i].type == 2
                                    ? "suggestion".tr
                                    : "question".tr,
                            date: controller.listComplaints[i].createdAt ??
                                '2024-06-13',
                            description:
                                controller.listComplaints[i].description!,
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
