import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/home/controllers/home_controller.dart';
import 'package:musaneda/components/hourly/return_back_btn.dart';
import 'package:musaneda/config/myColor.dart';

class AboutMusanedaWebview extends GetView<HomeController> {
  const AboutMusanedaWebview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary.withOpacity(0.1),
        title: Text('about_us'.tr,
            style: TextStyle(color: MYColor.primary, fontSize: 20.0)),
        leading: ReturnButton(color: MYColor.primary, size: 20.0),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark),
      ),
      body: GetBuilder<HomeController>(
          init: controller,
          builder: (controller) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              color: MYColor.primary.withOpacity(0.1),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 30.0, top: 10.0),
                      child: Center(
                        child: Image.asset(
                          'assets/images/hamaLogo.png',
                          height: 80.0,
                          width: 150.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5.0, top: 10.0),
                      child: Text(
                        'app_name'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MYColor.black,
                            fontSize: 20.0),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        textAlign: TextAlign.justify,

                        'about_musaneda_desc'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MYColor.primary,
                            fontSize: 15.0),
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                     RichText(
                        text: TextSpan(
                            text: 'v  ',
                            style: TextStyle(
                              fontFamily: 'cairo_regular',
                              fontSize: 20.0,
                              color: MYColor.secondary1,
                            ),
                            children: [
                          TextSpan(
                            text: controller.versions.value,
                            style: TextStyle(
                              fontFamily: 'cairo_regular',
                              fontSize: 17,
                              color: MYColor.secondary1,
                            ),
                          ),
                        ])),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
