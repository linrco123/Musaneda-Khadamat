import 'package:flutter/material.dart';
import 'package:musaneda/config/myColor.dart';
import 'customed_details_widget.dart';

class AddressDetailsWidget extends StatelessWidget {
  final String title;
  final TextEditingController controler;
  final TextInputType textInputType;
  final bool isEnabled;
  const AddressDetailsWidget({super.key, required this.title, required this.controler, required this.textInputType, required this.isEnabled , });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14.0,
                color: MYColor.primary,
                fontWeight: FontWeight.bold),
          ),
        ),
        CustomedTextField(context, controler, title , textInputType , isEnabled),
      ],
    );
  }
}
