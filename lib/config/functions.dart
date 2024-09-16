import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/routes/app_pages.dart';
import 'package:musaneda/config/myColor.dart';

Future<bool> exitAlertApp() {
  Get.defaultDialog(
      backgroundColor: MYColor.primary,
      title: 'alert'.tr,
      titleStyle: const TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          //decoration: TextDecoration.underline,
          color: Colors.white),
      middleText: 'question_close'.tr,
      middleTextStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
      actions: [
        ElevatedButton(
            onPressed: () {
              exit(0);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('ok'.tr),
            )),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('cancel'.tr)),
      ]);

  return Future.value(true);
}

String normalizeArabicNumbers(String text) {
  // Mapping Arabic-Indic numerals to Western Arabic numerals
  const Map<String, String> arabicToEnglishNumerals = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
  };

  // Replace each Arabic numeral with the corresponding English numeral
  arabicToEnglishNumerals.forEach((arabicNum, englishNum) {
    text = text.replaceAll(arabicNum, englishNum);
  });

  return text;
}

bool containsArabicNumerals(String text) {
  // Check for Arabic-Indic numerals (٠-٩)
  final arabicRegex = RegExp(r'[\u0660-\u0669]');
  return arabicRegex.hasMatch(text);
}

void showLoginSignupDialogue(context) {
  var languageController = Get.put(LanguageController());
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shadowColor: MYColor.primary,
        title: Text(
          'alert'.tr,
          textAlign: TextAlign.center,
        ),
        titleTextStyle: TextStyle(color: MYColor.white, fontSize: 27.0),
        content: Text(
          'login_signup_heading'.tr,
          textAlign: TextAlign.center,
        ),
        contentTextStyle: TextStyle(
            color: MYColor.white, fontSize: 16.0, fontFamily: 'cairo_regular',fontWeight: FontWeight.bold),
        backgroundColor: MYColor.secondary,
        clipBehavior: Clip.antiAlias,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              logInSignupButton(
                  title: 'log_in'.tr, languageController: languageController),
              logInSignupButton(
                  title: 'sign_up'.tr, languageController: languageController),
            ],
          )
        ],
      );
    },
  );
}

Widget logInSignupButton({String? title, dynamic languageController}) =>
    Container(
      width: 125.0,
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      decoration: BoxDecoration(
          color: MYColor.primary.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      child: Center(
        child: TextButton(
            onPressed: () {
              Get.offAllNamed(Routes.LOGIN);
            },
            child: Text(
              title!,
              style: TextStyle(
                  color: MYColor.secondary1,
                  fontSize: languageController.isEnglish ? 18.0 : 14.0,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
