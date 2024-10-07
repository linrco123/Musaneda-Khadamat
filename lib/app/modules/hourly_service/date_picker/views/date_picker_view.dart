import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/hourly_service/date_picker/controllers/date_picker_controller.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/controllers/servicetype_controller.dart';
import 'package:musaneda/app/routes/app_pages.dart';
import 'package:musaneda/components/myCupertinoButton.dart';
import 'package:musaneda/components/mySnackbar.dart';
import 'package:musaneda/config/myColor.dart';

class DatePickerView extends GetView<DatePickerController> {
  const DatePickerView({super.key});

  @override
  Widget build(BuildContext context) {
    final datePickerController = Get.put(DatePickerController());
    final serviceTypeController = Get.put(ServiceTypeController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: MYColor.primary,
              size: 25.0,
            )),
        backgroundColor: MYColor.primary.withOpacity(0.1),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        color: MYColor.primary.withOpacity(0.1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/hamaLogo.png',
                height: 80.0,
                width: 150.0,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 30.0,
                    color: MYColor.primary.withOpacity(0.7),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ), //'visit_date' 'start_v_date'
                  Text(
                    serviceTypeController.visitsNumber.value == 2
                        ? 'visit_date'.tr
                        : 'start_v_date'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MYColor.primary,
                        fontSize: 17.0),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              SizedBox(
                  width: Get.width,
                  height: Get.height / 2.1,
                  child: DatePicker(
                    initialDate: DateTime.now(),
                    minDate: DateTime.now(), //? maybe after today with 2 days
                    maxDate: DateTime(DateTime.now().year + 1, 12, 30),
                    //disabledDayPredicate: ,
                    initialPickerType: PickerType.days,
                    highlightColor: MYColor.primary,
                    splashRadius: 10.0,
                    disabledDayPredicate: (date) {
                      if(date.weekday == 5 || date.weekday == 6){
                        return true;
                      }else{
                        return false;
                      }
                    },
                    daysOfTheWeekTextStyle: TextStyle(
                      fontSize: 16.0,
                        color: MYColor.primary.withOpacity(0.6),
                        fontWeight: FontWeight.bold),
                    padding: EdgeInsets.zero,
                    centerLeadingDate: true,
                    leadingDateTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: MYColor.black),

                    selectedCellDecoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: MYColor.primary,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: MYColor.primary.withOpacity(0.3),
                            width: 1.0)),
                    selectedCellTextStyle: TextStyle(
                        color: MYColor.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                    enabledCellsTextStyle: TextStyle(
                        color: MYColor.primary,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                    enabledCellsDecoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: MYColor.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: MYColor.primary.withOpacity(0.3),
                            width: 1.0)),
                    disabledCellsDecoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: MYColor.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: MYColor.primary.withOpacity(0.2))),
                    disabledCellsTextStyle: TextStyle(
                        color: MYColor.primary.withOpacity(0.3),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                    currentDate: DateTime.now(),
                    onDateSelected: (value) {
                      if (value.weekday == 5 || value.weekday == 6) {
                        mySnackBar(
                          message: 'thurs_fri_days_service'.tr,
                          color: MYColor.warning,
                          title: 'warning'.tr,
                          icon: Icons.warning,
                        );
                      } else {
                        datePickerController.selectDateTime(value);
                      }
                    },
                  )),

              const SizedBox(
                height: 5.0,
              ),
              Obx(
                () => datePickerController.selectedDate.value.isEmpty
                    ? SizedBox(
                        height: Get.height / 47,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                  maxLines: 1,
                                  datePickerController.selectedDate.value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MYColor.primary,
                                      fontSize: 17.0)),
                            ),
                          ),
                        ],
                      ),
              ),
              //const Spacer(),
              SizedBox(
                height: Get.height / 15,
              ),
              SizedBox(
                width: Get.width,
                height: 60.0,
                child: MyCupertinoButton(
                    fun: () {
                      if (datePickerController.selectedDate.value.isNotEmpty) {
                        Get.toNamed(Routes.SHOWADDRESS);
                        return;
                      }
                      mySnackBar(
                        message: 'pick_date'.tr,
                        color: MYColor.warning,
                        title: 'warning'.tr,
                        icon: Icons.warning,
                      );
                    },
                    text: 'confirm_date'.tr,
                    btnColor: MYColor.buttons,
                    txtColor: MYColor.btnTxtColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
