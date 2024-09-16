import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/controllers/servicetype_controller.dart';
import 'package:musaneda/config/constance.dart';
import 'package:musaneda/config/myColor.dart';

class HourOrdersView extends GetView<ServiceTypeController> {
  const HourOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    var serviceTypeController = Get.put(ServiceTypeController());

    return Container(
      height: double.infinity,
      width: double.infinity,
      color: MYColor.primary.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: GetBuilder<ServiceTypeController>(
          init: controller,
          builder: (controller) {
            // if (controller.isLoading.value) {
            //   return Center(
            //       child: LoadingAnimationWidget.waveDots(
            //           color: MYColor.primary, size: 50.0 ));
            // }
            return Stack(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    serviceTypeController.listHourOrders.isEmpty
                        ? Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              'no_hour_orders'.tr,
                              style: TextStyle(
                                  fontFamily: 'cairo_regular',
                                  color: MYColor.grey,
                                  fontSize: 18.0),
                            ),
                          )
                        : Expanded(
                            child: Obx(
                              () => LazyLoadScrollView(
                                onEndOfPage: () {
                                  serviceTypeController.getMoreHourOrders();
                                },
                                isLoading: serviceTypeController.lastPage.value,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: serviceTypeController
                                      .listHourOrders.length,
                                  itemBuilder: (context, i) {
                                    final hourOrder =
                                        serviceTypeController.listHourOrders[i];
                                    return Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(15.0),
                                            //height: 80.0,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: MYColor.primary
                                                          .withOpacity(0.2),
                                                      blurRadius: 5.0,
                                                      offset:
                                                          const Offset(1, 1))
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: MYColor.white),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      hourOrder.package!.title!,
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          color:
                                                              MYColor.primary,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      decoration: BoxDecoration(
                                                          color: MYColor.primary
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            hourOrder.cost!
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: MYColor
                                                                    .primary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          Text('sar'.tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  color: MYColor
                                                                      .primary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 1.0,
                                                      horizontal: 5.0),
                                                  child: Divider(
                                                    color: MYColor.primary
                                                        .withOpacity(0.3),
                                                    thickness: 1.0,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'period'.tr,
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              color:
                                                                  MYColor.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text(
                                                          hourOrder
                                                              .package!.shift!,
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              color: MYColor
                                                                  .primary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'time'.tr,
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              color:
                                                                  MYColor.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10.0),
                                                              child: Text(
                                                                  'from'.tr,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.0,
                                                                      color: MYColor
                                                                          .primary,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ),
                                                            Text(
                                                              hourOrder
                                                                  .package!
                                                                  .fromTime
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  color: MYColor
                                                                      .primary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10.0),
                                                                child: Text(
                                                                    'to'.tr,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14.0,
                                                                        color: MYColor
                                                                            .primary,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                            Text(
                                                              hourOrder
                                                                  .package!
                                                                  .endTime!
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  color: MYColor
                                                                      .primary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'hours_number'.tr,
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              color:
                                                                  MYColor.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              hourOrder.package!
                                                                  .duration!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  color: MYColor
                                                                      .primary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            Text(
                                                              'hours'.tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  color: MYColor
                                                                      .primary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 1.0,
                                                        horizontal: 5.0),
                                                    child: Divider(
                                                      color: MYColor.primary
                                                          .withOpacity(0.3),
                                                      thickness: 1.0,
                                                    )),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'date'.tr,
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              color:
                                                                  MYColor.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text(
                                                          hourOrder.fromDate!,
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              color: MYColor
                                                                  .primary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'status'.tr,
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              color:
                                                                  MYColor.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text(
                                                          hourOrder
                                                              .paymentStatus!,
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              color: MYColor
                                                                  .primary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                              ),
                            ),
                          )
                  ],
                ),
                Obx(
                  () => controller.isLoading.value && Constance.getToken().isNotEmpty
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: LoadingAnimationWidget.waveDots(
                              color: MYColor.primary, size: 50.0),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            );
          }),
    );
  }
}
