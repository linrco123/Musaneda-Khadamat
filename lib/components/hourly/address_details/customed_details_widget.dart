

 import 'package:flutter/material.dart';
import 'package:musaneda/config/myColor.dart';

TextFormField CustomedTextField(BuildContext context,controller,text , keyboardType , isEnabled) {
    return TextFormField(
      enabled:isEnabled ,
      controller: controller,
      keyboardType: keyboardType,
      textAlign: TextAlign.start,
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return 'please_enter_title'.tr;
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
       // labelText: text,
        labelStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        hintText: text,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 12,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }