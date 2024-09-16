import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/config/myColor.dart';

class ReturnButton extends StatelessWidget {
  final Color color;
  final double size;
  const ReturnButton({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: color,
          size: size,
        ));
  }
}

class CircledBackButton extends StatelessWidget {
  const CircledBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Container(
        width: 30,
        height: 30,
        decoration:
            BoxDecoration(color: MYColor.buttons, shape: BoxShape.circle),
        child: Icon(
          !LanguageController.I.isEnglish
              ? Icons.arrow_back
              : Icons.arrow_forward,
          color: MYColor.white,
        ),
      ),
    );
  }
}
