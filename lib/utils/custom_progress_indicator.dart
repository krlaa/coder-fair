import 'package:coder_fair/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomProgress extends StatelessWidget {
  const CustomProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(color: AppColor.buttonGreen));
  }
}
