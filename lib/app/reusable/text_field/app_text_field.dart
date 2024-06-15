import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unsplash_img/app/constants/index.dart';
import '../index.dart';

class AppTextField extends StatelessWidget {
  final String? placeholder;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function()? suffixOnTap;
  final void Function(String) onChange;

  const AppTextField(
      {super.key,
      this.placeholder,
      this.controller,
      this.focusNode,
        required this.onChange,
      this.suffixOnTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(

      cursorColor: appColors.xff67864a,
      prefix: const Padding(
        padding: EdgeInsets.only(left: 15),
        child: Icon(CupertinoIcons.search),
      ),
      suffix: GestureDetector(
        onTap: suffixOnTap,
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Icon(
            Icons.close,
            color: rcolor,
          ),
        ),
      ),
      // keyboardAppearance:
      //     localUser.getBool('darkmode')! ? Brightness.dark : Brightness.light,
      focusNode: focusNode,
      controller: controller,
      placeholder: placeholder,
      placeholderStyle: latoText.get16.space02.w500
          .textColor(appColors.xff000000.withOpacity(0.5)),
      style: latoText.get16.space02.w500.textColor(appColors.xff000000),
      decoration: const BoxDecoration(),
      maxLines: 1,
      onChanged: onChange,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLength: 50,
      padding: const EdgeInsets.all(16.0),
    );
  }
}
