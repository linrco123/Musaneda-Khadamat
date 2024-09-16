// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/myColor.dart';
import 'myCupertinoButton.dart';

void myWarningDialog({
  required String title,
  required String content,
  required String cancel,
  required String confirm,
  required Function funConfirm,
  required Function funCancel,
  required Function funWillPop,
}) =>
    Get.defaultDialog(
        backgroundColor: MYColor.primary,
        title: title,
        titleStyle: TextStyle(
          color: MYColor.warning,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'cairo_medium',
        ),
        radius: 8,
        titlePadding: const EdgeInsets.only(top: 20),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          children: [
            Text(
              content,
              style: TextStyle(
                color: MYColor.white,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
              strutStyle: const StrutStyle(
                height: 2.5,
              ),
            ),
          ],
        ),
        cancel: SizedBox(
          width: 115,
          height: 45,
          child: MyCupertinoButton(
            btnColor: MYColor.accent,
            txtColor: MYColor.black,
            text: cancel,
            fun: () => funCancel(),
          ),
        ),
        confirm: SizedBox(
          width: 115,
          height: 45,
          child: MyCupertinoButton(
            btnColor: MYColor.error,
            txtColor: MYColor.white,
            text: confirm,
            fun: () => funConfirm(),
          ),
        ),
        onWillPop: () => funWillPop());
