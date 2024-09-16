


import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:musaneda/config/myColor.dart';

class DisabledShiftTypeWidget extends StatelessWidget{
  const DisabledShiftTypeWidget({super.key});

  @override
  Widget build(Object context) {
    return Row(
      children: [
        Container(
            height: 40.0,
            width: 100,
            decoration: BoxDecoration(
                color: MYColor.primary ,
                borderRadius: BorderRadius.circular(20.0)),
            child: Center(
              child: Text(
                'morning'.tr,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: MYColor.white),
              ),
            ),
          ),
          const SizedBox(width: 10.0,),
          Container(
        height: 40.0,
        width: 100,
        decoration: BoxDecoration(
            color:  MYColor.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.0)),
        child: Center(
          child: Text(
            'evening'.tr,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: MYColor.grey),
          ),
        ),
      ),

      ],
    );
  }
}