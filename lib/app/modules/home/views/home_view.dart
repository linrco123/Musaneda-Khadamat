// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/home/views/about_musaneda.dart';
import 'package:musaneda/app/modules/home/views/taps/contract_tap.dart';
import 'package:musaneda/app/modules/home/views/techincal_support_webView.dart';
import 'package:musaneda/app/modules/hourly_service/mediation/views/mediation_view.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/views/hour_orders_view.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/views/service_type_view.dart';
import 'package:musaneda/app/modules/hourly_service/welcome/views/welcome_view.dart';
import 'package:musaneda/app/modules/login/controllers/login_controller.dart';
import 'package:musaneda/app/routes/app_pages.dart';
import 'package:musaneda/config/constance.dart';
import 'package:musaneda/config/functions.dart';
import 'package:musaneda/config/myColor.dart';
import '../../../controllers/language_controller.dart';
import '../../register/views/terms_conditions_webview.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final _drawer = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      key: const ValueKey("home-view"),
      init: controller,
      builder: (ctx) {
        return AdvancedDrawer(
          backdropColor: MYColor.primary,
          controller: _drawer,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          drawer: myDrawer(context),
          child: Scaffold(
            appBar: myAppBar(context),
            body: WillPopScope(onWillPop: exitAlertApp, child: myHome(context)),
            bottomNavigationBar: Container(
              height: 85,
              decoration: BoxDecoration(
                color: MYColor.transparent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                border: Border.fromBorderSide(
                  BorderSide(
                    color: MYColor.accent,
                    width: 1,
                  ),
                ),
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      controller.setTap = 0;
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 60,
                      width: Get.width / 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: controller.tap.value == 0
                                    ? MYColor.primary.withOpacity(0.1)
                                    : MYColor.white,
                                shape: BoxShape.circle),

                            // height: 25,
                            // width: 25,
                            padding: const EdgeInsets.all(5.0),
                            child: SvgPicture.asset(
                              "assets/images/bar/home_black.svg",
                              fit: BoxFit.fill,
                              color: controller.tap.value == 0
                                  ? MYColor.buttons
                                  : MYColor.grey,
                              height: controller.tap.value == 0 ? 15 : 25.0,
                              width: controller.tap.value == 0 ? 15 : 25.0,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "home".tr,
                            style: TextStyle(
                              color: controller.tap.value == 0
                                  ? MYColor.buttons
                                  : MYColor.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      //controller.setPrev();
                      controller.setTap = 1;
                      //myFilterDialog(context);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 60,
                      width: Get.width / 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: controller.tap.value == 1
                                    ? MYColor.primary.withOpacity(0.1)
                                    : MYColor.white,
                                shape: BoxShape.circle),

                            // height: 25,
                            // width: 25,
                            padding: const EdgeInsets.all(0.0),
                            child: SvgPicture.asset(
                              "assets/images/bottom/neworder.svg",
                              fit: BoxFit.fill,
                              color: controller.tap.value == 1
                                  ? MYColor.buttons
                                  : MYColor.grey,
                              height: controller.tap.value == 1 ? 20.0 : 30.0,
                              width: controller.tap.value == 1 ? 20.0 : 30.0,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "new_order".tr,
                            style: TextStyle(
                              color: controller.tap.value == 1
                                  ? MYColor.buttons
                                  : MYColor.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      controller.setTap = 2;
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 60,
                      width: Get.width / 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: controller.tap.value == 2
                                    ? MYColor.primary.withOpacity(0.1)
                                    : MYColor.white,
                                shape: BoxShape.circle),

                            // height: 25,
                            // width: 25,
                            padding: const EdgeInsets.all(5.0),
                            child: SvgPicture.asset(
                              "assets/images/bottom/housemaid.svg",
                              fit: BoxFit.fill,
                              color: controller.tap.value == 2
                                  ? MYColor.buttons
                                  : MYColor.grey,
                              height: controller.tap.value == 2 ? 15 : 25.0,
                              width: controller.tap.value == 2 ? 15 : 25.0,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "moquima".tr,
                            style: TextStyle(
                              color: controller.tap.value == 2
                                  ? MYColor.buttons
                                  : MYColor.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      controller.setTap = 3;
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 60,
                      width: Get.width / 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: controller.tap.value == 3
                                    ? MYColor.primary.withOpacity(0.1)
                                    : MYColor.white,
                                shape: BoxShape.circle),
                            padding: const EdgeInsets.all(5.0),
                            child: SvgPicture.asset(
                              "assets/images/bottom/hours.svg",
                              fit: BoxFit.fill,
                              color: controller.tap.value == 3
                                  ? MYColor.buttons
                                  : MYColor.grey,
                              height: controller.tap.value == 3 ? 15 : 25.0,
                              width: controller.tap.value == 3 ? 15 : 25.0,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "hour".tr,
                            style: TextStyle(
                              color: controller.tap.value == 3
                                  ? MYColor.buttons
                                  : MYColor.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      controller.setTap = 4;
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 60,
                      width: Get.width / 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: controller.tap.value == 4
                                    ? MYColor.primary.withOpacity(0.1)
                                    : MYColor.white,
                                shape: BoxShape.circle),
                            padding: const EdgeInsets.all(0.0),
                            child: SvgPicture.asset(
                              "assets/images/bottom/handshake.svg",
                              fit: BoxFit.cover,
                              color: controller.tap.value == 4
                                  ? MYColor.buttons
                                  : MYColor.grey,
                              height: controller.tap.value == 4 ? 20 : 30.0,
                              width: controller.tap.value == 4 ? 20 : 30.0,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "mediation".tr,
                            style: TextStyle(
                              color: controller.tap.value == 4
                                  ? MYColor.buttons
                                  : MYColor.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget myHome(context) {
    switch (controller.tap.value) {
      case 0:
        return const WelcomeView();
      case 1:
        return const ServiceTypeView();
      case 2:
        return contractsTap(context);
      case 3:
        return const HourOrdersView();
      case 4:
        return const MediationView();
      default:
        return const WelcomeView();
    }
  }

  PreferredSizeWidget myAppBar(BuildContext context) {
    return myHomeAppBar(context);
  }

  Widget myDrawerIcon(context, Color color) {
    return IconButton(
      onPressed: () {
        _drawer.showDrawer();
      },
      icon: ValueListenableBuilder<AdvancedDrawerValue>(
        valueListenable: _drawer,
        builder: (_, value, __) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: SvgPicture.asset(
              value.visible
                  ? 'assets/images/drawer/drawer.svg'
                  : 'assets/images/drawer/drawer.svg',
              key: ValueKey<bool>(value.visible),
              color: color,
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget myHomeAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: MYColor.primary.withOpacity(0.1),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.tap.value == 2
                ? 'moquima_orders'.tr
                : controller.tap.value == 3
                    ? 'hour_orders'.tr
                    : controller.tap.value == 4
                        ? 'mediations_orders'.tr
                        : 'app_name'.tr,
            style: TextStyle(
              color: MYColor.buttons,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.toNamed(Routes.NOTIFICATION);
             },
            icon: const Icon(
              Icons.notifications_none,
              size: 25.0,
            )),
        controller.tap.value != 0 && controller.tap.value != 1
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: IconButton(
                  onPressed: () {
                    controller.setTap = 1;
                  },
                  icon: SvgPicture.asset(
                    'assets/images/icon/plus.svg',
                    color: MYColor.primary,
                    height: 22,
                    width: 22,
                  ),
                ),
              )
            : const SizedBox()
      ],
      centerTitle: true,
      iconTheme: IconThemeData(
        color: MYColor.buttons,
        size: 20,
      ),
      leading: myDrawerIcon(context, MYColor.buttons),
    );
  }

  void showLanguageDialog(context) {
    showModalBottomSheet(
      constraints: const BoxConstraints(
        maxHeight: 195,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (ctx) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "language".tr,
                style: TextStyle(
                  color: MYColor.primary,
                  fontFamily: 'cairo_medium',
                  fontSize: 16,
                ),
              ),
            ),
            Obx(
              () => SizedBox(
                height: 120,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Divider(
                        color: MYColor.buttons.withOpacity(0.2),
                      ),
                    );
                  },
                  itemCount: LanguageController.I.lang.length,
                  itemBuilder: (ctx, i) {
                    // _drawer.hideDrawer();
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: InkWell(
                        onTap: () {
                          LanguageController.I.changeLocale(
                            LanguageController.I.lang[i],
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                LanguageController.I.lang[i] == 'english'
                                    ? "assets/images/en.png"
                                    : "assets/images/ar1.png",
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              LanguageController.I.lang[i].tr,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const Spacer(),
                            LanguageController.I.getLocale.startsWith("a") ==
                                    LanguageController.I.lang[i].startsWith("a")
                                ? Icon(
                                    CupertinoIcons.checkmark_circle,
                                    color: MYColor.buttons,
                                    size: 25.0,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void showLogInSignupRequest(context) {
    showModalBottomSheet(
      constraints: const BoxConstraints(
        maxHeight: 220.0,
      ),
      backgroundColor: MYColor.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
              ),
              const Spacer(),
              Text('have_no_account'.tr,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: MYColor.white,
                      fontFamily: 'cairo_regular',
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                  textAlign: TextAlign.center,
                  "see_personal_data".tr,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: MYColor.white,
                      fontFamily: 'cairo_regular',
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0),
              //         IconButton(
              //   onPressed: () {
              //     Get.offAllNamed(Routes.LOGIN);
              //   },
              //   icon: Icon(
              //     Icons.arrow_circle_right_outlined,
              //     color: MYColor.white,
              //     size: 30.0,
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                    color: MYColor.secondary.withOpacity(0.6),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(20.0))),
                child: TextButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    child: Text(
                      'go'.tr,
                      style: TextStyle(
                          color: MYColor.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }

  Widget myDrawer(context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(
                  top: 40.0,
                  bottom: 10.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/images/drawer/user.svg',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Text(
                  Constance.getName().isNotEmpty
                      ? Constance.getName()
                      : 'guest'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              ListTile(
                onTap: () {
                  if (Constance.getToken().isNotEmpty) {
                    Get.toNamed(Routes.PROFILE);
                  } else {
                    showLogInSignupRequest(context);
                  }
                },
                leading: SvgPicture.asset(
                  'assets/images/drawer/person.svg',
                  color: Constance.getToken().isNotEmpty
                      ? MYColor.white
                      : Colors.white54,
                ),
                title: Text(
                  'profile'.tr,
                  style: TextStyle(
                      color: Constance.getToken().isNotEmpty
                          ? MYColor.white
                          : Colors.white54),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.DELEGATION);
                },
                leading: SvgPicture.asset(
                  'assets/images/drawer/delegation.svg',
                ),
                title: Text('delegation'.tr),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.LOCATIONS);
                },
                leading: SvgPicture.asset(
                  'assets/images/drawer/location.svg',
                ),
                title: Text('location'.tr),
              ),
              ListTile(
                onTap: () {
                  showLanguageDialog(context);
                },
                leading: SvgPicture.asset(
                  'assets/images/drawer/language.svg',
                ),
                title: Text('language'.tr),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.COMPLAINT);
                },
                leading: SvgPicture.asset(
                  'assets/images/drawer/complain.svg',
                ),
                title: Text('tickets'.tr),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => const TechnicalSupportWebview());
                  //launchUrl(Uri.parse("https://kdamat.com/Alwatniaco_Webchat.html"));
                },
                leading: const Icon(CupertinoIcons.chat_bubble_2),
                title: Text('technical_support'.tr),
              ),
              ListTile(
                onTap: () async {
                  await controller.whatsapp();
                },
                leading: Image.asset(
                  'assets/images/whatsapp.png',
                  width: 20.0,
                  height: 20.0,
                  color: MYColor.white,
                ),
                title: Text('whats_app'.tr),
              ),
              ListTile(
                onTap: () async {
                  await controller.makePhoneCall();
                },
                leading: const Icon(CupertinoIcons.phone_arrow_up_right),
                title: Text('contact_us'.tr),
              ),
              ListTile(
                onTap: () {
                  Get.to(const AboutMusanedaWebview());
                },
                leading: SvgPicture.asset(
                  'assets/images/bar/contracts_black.svg',
                  height: 20.0,
                  width: 20.0,
                  color: MYColor.white,
                ),
                title: Text('about_musaneda'.tr),
              ),
              ListTile(
                onTap: () => LoginController.I.logout(),
                leading: SvgPicture.asset(
                  'assets/images/drawer/logout.svg',
                ),
                title: Text('logout'.tr),
              ),
              // const Spacer(),

              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const TermsConditionsWebview());
                    },
                    child: Text(
                      '${'service_terms'.tr} | ${'privacy_policy'.tr}',
                      style: const TextStyle(
                        fontFamily: 'cairo_regular',
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20.0, top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'V',
                      style: TextStyle(
                        fontFamily: 'cairo_regular',
                        fontSize: 13,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      controller.versions.value,
                      style: const TextStyle(
                        fontFamily: 'cairo_regular',
                        fontSize: 15,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
