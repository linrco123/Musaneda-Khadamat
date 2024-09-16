import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/config/myColor.dart';

class WelcomeCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final void Function()? onPressed;

  const WelcomeCard(
      {super.key,
      required this.title,
      required this.description,
      required this.image, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Card(
        elevation: 1.0,
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          //height: 300,
          width: Get.width,
          decoration: BoxDecoration(color: MYColor.secondary.withOpacity(0.1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30.0,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 18.0,
                    color: MYColor.primary,
                    fontFamily: 'cairo_regular',
                    fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: TextStyle(
                    fontSize: 13.0,
                     fontFamily: 'cairo_regular',
                    color: MYColor.secondary1,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Stack(
                children: [
                  Container(
                    height: 160.0,
                    width: 280.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: MYColor.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Image.asset(
                      image,
                      height: 160.0,
                      width: 280.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 10.0,
                    top: 5.0,
                    child: Image.asset(
                      'assets/images/hamaLogo.png',
                      height: 50.0,
                      width: 50.0,
                      //fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              CupertinoButton(
                  borderRadius: BorderRadius.circular(10.0),
                  color: MYColor.buttons,
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical:10.0),
                  minSize: 30.0,
                  onPressed: onPressed,
                  child: Text(
                    'check_service'.tr,
                    style: TextStyle(
                        fontSize: 17.0,
                        color: MYColor.btnTxtColor,
                        fontFamily: 'cairo_regular'),
                  )),
              const SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
