import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/home/controllers/home_controller.dart';
import 'package:musaneda/app/modules/hourly_service/welcome/controllers/welcome_controller.dart';
import 'package:musaneda/components/hourly/welcome/welcome_card.dart';
import 'package:musaneda/config/constance.dart';
import 'package:musaneda/config/myColor.dart';

class WelcomeView extends GetView<HomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var welcomeController = Get.put(WelcomeController());
    return GetBuilder<HomeController>(
      init: controller,
      builder: (controller) => Scaffold(
        body: Container(
          color: MYColor.primary.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Center(
                    child: Image.asset(
                      'assets/images/hamaLogo.png',
                      height: 80.0,
                      width: 150.0,
                      // fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          alignment: Alignment.center,
                          height: Get.height / 4,
                          width: Get.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: LanguageController.I.isEnglish
                                      ? Alignment.bottomLeft
                                      : Alignment.topRight,
                                  end: LanguageController.I.isEnglish
                                      ? Alignment.topRight
                                      : Alignment.bottomLeft,
                                  stops: const [
                                0.0,
                                0.5,
                                1.0
                              ],
                                  colors: [
                                MYColor.primary,
                                MYColor.primary.withOpacity(0.6),
                                MYColor.primary.withOpacity(0.2),
                              ])),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 7.0, right: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        welcomeController.greetings(),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            // height: 1.7,
                                            color: MYColor.white,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        Constance.getName().isNotEmpty
                                            ? Constance.getName()
                                            : 'guest'.tr,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: MYColor.white,
                                            fontWeight: FontWeight.w900),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Image.asset(
                                        'assets/images/sunrise2.png',
                                        height: 70,
                                        width: 70,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      WelcomeCard(
                        onPressed: controller.changeWelcomeScreen,
                        title: 'hama_offers'.tr,
                        description: 'one_time_visit'.tr,
                        image: 'assets/images/maid.jpg',
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      WelcomeCard(
                        onPressed: controller.changeWelcomeScreen,
                        title: 'stayin_offers'.tr,
                        description: '3month_maid'.tr,
                        image: 'assets/images/maid1.jpeg',
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
