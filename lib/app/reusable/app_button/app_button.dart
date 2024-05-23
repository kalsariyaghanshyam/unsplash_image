import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/index.dart';

class AppButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const AppButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [appColors.xff47b540, appColors.xff649676],
            stops: const [0, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(50),
          color: appColors.xff34B233,
        ),
        child: Padding(
          padding:
          EdgeInsets.symmetric(vertical: Get.height * 0.018),
          child: Text(text ,
              textAlign: TextAlign.center,
              style: prozaLibreText.get22.w500.xffFFFFFF),
        ),
      ),
    );
  }
}
