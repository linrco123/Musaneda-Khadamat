import 'package:flutter/material.dart';
import 'package:musaneda/config/myColor.dart';

class WorkingHoursButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final void Function() onTap;
  const WorkingHoursButton(
      {super.key, required this.title, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.0,
        width: 100,
        decoration: BoxDecoration(
            color: isActive ? MYColor.primary : MYColor.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.0)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: isActive ? MYColor.white : MYColor.grey),
          ),
        ),
      ),
    );
  }
}
