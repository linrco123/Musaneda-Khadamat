import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/hourly_service/mediation/controllers/mediation_controller.dart';
import 'package:musaneda/components/hourly/return_back_btn.dart';
import 'package:musaneda/components/myCupertinoButton.dart';
import 'package:musaneda/components/myDropdown.dart';
import 'package:musaneda/config/myColor.dart';

class AddMediationView extends GetView<MediationController> {
  const AddMediationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MediationController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary.withOpacity(0.2),
        title: Text('mediation_service'.tr,
            style: TextStyle(color: MYColor.primary, fontSize: 18.0)),
        leading: ReturnButton(color: MYColor.primary, size: 20.0),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        color: MYColor.primary.withOpacity(0.2),
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<MediationController>(
          init: controller,
          builder: (controller) => Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Image.asset(
                'assets/images/hamaLogo.png',
                height: 80.0,
                width: 150.0,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Form(
                key: controller.formKey,
                child: Expanded(
                  child: controller.isLoading.value
                      ? Center(
                          child: LoadingAnimationWidget.waveDots(
                              color: MYColor.primary, size: 50.0),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Obx(
                                () => myDropdown(
                                  context: context,
                                  value: controller.nationality.value,
                                  onChanged: (value) {
                                    controller.setNationality = value;
                                  },
                                  items: controller.nationalityList.map((item) {
                                    return DropdownMenuItem(
                                      value: item.id,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: Text(
                                          LanguageController.I.isEnglish
                                              ? item.name!.en!
                                              : item.name!.ar!,
                                          style: TextStyle(
                                            color: MYColor.primary,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'cairo_regular',
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Obx(
                                () => myDropdown(
                                  context: context,
                                  value: controller.selectedJob.value,
                                  onChanged: (value) {
                                    controller.setJob = value;
                                  },
                                  items: controller.jobsList.map((item) {
                                    return DropdownMenuItem(
                                      value: item.id,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: Text(
                                          LanguageController.I.isEnglish
                                              ? item.name!.en!
                                              : item.name!.ar!,
                                          style: TextStyle(
                                            color: MYColor.primary,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'cairo_regular',
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Obx(
                                () => myDropdown(
                                  context: context,
                                  value: controller.selectedExperience.value,
                                  onChanged: (value) {
                                    controller.setExperience = value;
                                  },
                                  items: controller.experienceList.map((item) {
                                    return DropdownMenuItem(
                                      value: item.id,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: Text(
                                          LanguageController.I.isEnglish
                                              ? item.name!.en!
                                              : item.name!.ar!,
                                          style: TextStyle(
                                            color: MYColor.primary,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'cairo_regular',
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                textDirection: TextDirection.ltr,
                                keyboardType: TextInputType.phone,
                                controller: controller.cardNumberController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced),
                                  //CardNumberInputFormatter()
                                ],
                                validator: (number) =>
                                    controller.validateCardNumber(number),
                                decoration: InputDecoration(
                                    constraints:
                                        const BoxConstraints(maxHeight: 60.0),
                                    contentPadding: const EdgeInsets.only(
                                        top: 0.0,
                                        bottom: 0.0,
                                        left: 10.0,
                                        right: 10.0),
                                    hintStyle: TextStyle(
                                        color: MYColor.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0),
                                    hintText: "card_number".tr,
                                    labelText: "card_number".tr,
                                    labelStyle: TextStyle(
                                        color: MYColor.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MYColor.primary, width: 5.0),
                                    ),
                                    // focusedBorder: OutlineInputBorder(

                                    //   borderSide:
                                    //       BorderSide(color: MYColor.primary, width: 5.0),
                                    // ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MYColor.primary, width: 2.0),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MYColor.primary, width: 5.0),
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                              const SizedBox(
                                height: 50.0,
                              ),
                              SizedBox(
                                width: Get.width / 1.5,
                                height: 40.0,
                                child: MyCupertinoButton(
                                    fun: () {
                                      controller.sendMediationOptions();
                                    },
                                    text: 'send'.tr,
                                    btnColor: MYColor.buttons.withOpacity(0.7),
                                    txtColor: MYColor.btnTxtColor),
                              )
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
