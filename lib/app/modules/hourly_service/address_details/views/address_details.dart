import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/locations/controllers/locations_controller.dart';
import 'package:musaneda/components/hourly/address_details/address_details_widget.dart';
import 'package:musaneda/components/myCupertinoButton.dart';
import 'package:musaneda/config/myColor.dart';

class AddressDetailsView extends GetView<LocationsController> {
  const AddressDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var locationController = Get.find<LocationsController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'address_details'.tr,
          style: TextStyle(
              fontSize: 18.0,
              color: MYColor.primary,
              fontWeight: FontWeight.bold),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarIconBrightness: Brightness.dark),
        backgroundColor: MYColor.primary.withOpacity(0.1),
        foregroundColor: MYColor.primary.withOpacity(0.1),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: MYColor.primary,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        color: MYColor.primary.withOpacity(0.1),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: Center(
                      child: Image.asset(
                        'assets/images/hamaLogo.png',
                        height: 80.0,
                        width: 150.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  AddressDetailsWidget(
                    title: 'city'.tr,
                    controler: locationController.cityController,
                    textInputType: TextInputType.name,
                    isEnabled: false,
                  ),
                  AddressDetailsWidget(
                    title: 'district'.tr,
                    controler: locationController.districtController,
                    textInputType: TextInputType.name,
                    isEnabled: false,
                  ),
                  AddressDetailsWidget(
                    title: 'address_name'.tr,
                    controler: locationController.txtTitle,
                    textInputType: TextInputType.name,
                    isEnabled: true,
                  ),
                  AddressDetailsWidget(
                    title: 'street_name'.tr,
                    controler: locationController.txtNotes,
                    textInputType: TextInputType.name,
                    isEnabled: true,
                  ),
                  AddressDetailsWidget(
                    title: 'building_number'.tr,
                    controler: locationController.buildingController,
                    textInputType: TextInputType.number,
                    isEnabled: true,
                  ),
                  AddressDetailsWidget(
                    title: 'floor_number'.tr,
                    controler: locationController.floorController,
                    textInputType: TextInputType.number,
                    isEnabled: true,
                  ),

                  // AddressDetailsWidget(
                  //   title: 'zip_code'.tr,
                  //   controler: locationController.zipController,
                  //   textInputType: TextInputType.number,
                  // )
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 50.0,
              width: Get.width,
              child: MyCupertinoButton(
                  fun: () {
                    locationController.postHourlyLocation('hour');
                  },
                  text: 'confirm_address'.tr,
                  btnColor: MYColor.buttons,
                  txtColor: MYColor.white.withOpacity(0.9)),
            )
          ],
        ),
      ),
    );
  }
}
