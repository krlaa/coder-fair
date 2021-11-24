import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'constants/app_colors.dart';
import 'controllers/home_controller.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (_, __, ___) => GetMaterialApp(
        onInit: () {
          Get.put(HomeController());
        },
        theme: ThemeData(scaffoldBackgroundColor: mainBg),
        title: 'TCS Tampa CF',
        home: HomeScreen(),
      ),
    );
  }
}
