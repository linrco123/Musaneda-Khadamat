import 'package:flutter/material.dart';
import 'package:musaneda/config/myColor.dart';

class MaidsCounterButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const MaidsCounterButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.0,
        width: 40.0,
        color: MYColor.grey.withOpacity(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25.0, color: MYColor.primary),
            ),
          ],
        ),
      ),
    );
  }
}
