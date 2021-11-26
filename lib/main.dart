import 'package:coder_fair/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'constants/app_colors.dart';
import 'controllers/home_screen_controller.dart';
import 'controllers/login_screen_controller.dart';

void main() async {
  var box = await Hive.openBox('userPreferences');
  var exists = box.get('rememberPassword');
  if (exists == null) {
    box.put('rememberPassword', false);
  }

  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (_, __, ___) => GetMaterialApp(
        onInit: () {
          Get.put(LoginScreenController());
          Get.put(HomeScreenController());
        },
        theme: ThemeData(scaffoldBackgroundColor: mainBg),
        title: 'TCS Tampa CF',
        home: LoginScreen(),
      ),
    );
  }
}
