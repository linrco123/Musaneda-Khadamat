import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/config/myColor.dart';

class ServiceTypeCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool svg;
  final void Function() function;
  const ServiceTypeCard(
      {super.key,
      required this.title,
      required this.description,
      required this.function,
      required this.image,
      this.svg = false});
//'assets/images/drawer/delegation.svg'
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Card(
        elevation: 2.0,
        child: Container(
          //height: Get.height * 0.16,
          width: Get.width,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              svg
                  ? SvgPicture.asset(
                      image,
                      height: 50.0,
                      width: 50.0,
                      fit: BoxFit.fill,
                      color: MYColor.primary,
                    )
                  : Image.asset(
                      image,
                      height: 60.0,
                      width: 60.0,
                      fit: BoxFit.fill,
                      color: MYColor.primary,
                    ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: MYColor.primary,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      description,
                      style: TextStyle(
                        fontSize: 13.0,
                        color: MYColor.grey.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
