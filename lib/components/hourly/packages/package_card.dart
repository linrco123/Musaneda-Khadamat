import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/hourly_service/packages/packages_model.dart';
import 'package:musaneda/config/myColor.dart';

class MyPackageCard extends StatelessWidget {
  final PackageData package;
  final bool isActive;
  final void Function()? onTap;
  const MyPackageCard(
      {super.key, required this.package, required this.isActive, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        //height: 80.0,
        width: Get.width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: MYColor.primary.withOpacity(0.2),
                  blurRadius: 5.0,
                  offset: const Offset(1, 1))
            ],
            borderRadius: BorderRadius.circular(5.0),
            color: isActive ? MYColor.primary : MYColor.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  package.title!,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: isActive ? MYColor.white : MYColor.primary,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: isActive
                          ? MYColor.white.withOpacity(0.3)
                          : MYColor.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: [
                      Text(
                        package.cost!.toString(),
                        style: TextStyle(
                            fontSize: 14.0,
                            color: isActive ? MYColor.white : MYColor.primary,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text('sar'.tr,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: isActive ? MYColor.white : MYColor.primary,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
              child: Divider(
                color: isActive
                    ? MYColor.white.withOpacity(0.3)
                    : MYColor.primary.withOpacity(0.3),
                thickness: 1.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'period'.tr,
                      style: TextStyle(
                          fontSize: 14.0,
                          color:  MYColor.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      package.shiftText!,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: isActive ? MYColor.white : MYColor.primary,
                          fontWeight: FontWeight.bold),
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
                          color:  MYColor.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text('from'.tr,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: isActive ? MYColor.white : MYColor.primary,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          package.startFrom!.toString(),
                          style: TextStyle(
                              fontSize: 14.0,
                              color: isActive ? MYColor.white : MYColor.primary,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('to'.tr,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color:
                                        isActive ? MYColor.white : MYColor.primary,
                                    fontWeight: FontWeight.bold))),
                        Text(
                          package.endTo!.toString(),
                          style: TextStyle(
                              fontSize: 14.0,
                              color: isActive ? MYColor.white : MYColor.primary,
                              fontWeight: FontWeight.bold),
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
                          color:  MYColor.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          package.duration.toString(),
                          style: TextStyle(
                              fontSize: 14.0,
                              color: isActive ? MYColor.white : MYColor.primary,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'hours'.tr,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: isActive ? MYColor.white : MYColor.primary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
