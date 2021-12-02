import 'package:coder_fair/screens/home_screen.dart';
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
        home: HomeScreen(),
      ),
    );
  }
}

// TODO: Get rid of once your done

// Row(children:[
//   constraints.maxWidth> 1250 ?Column():Container(),
//   Column(children:[
//     Container(
//   width: constraints.maxWidth >=1920? 721 : constraints.maxWidth >= 820? 660: constraints.maxWidth >= 428 ? 346 : 200.sp
// )])
//  Container(
//   width: constraints.maxWidth >=1920? 721 : constraints.maxWidth >= 820? 660: constraints.maxWidth >= 428 ? 346 : 200.sp
// )])
//  Container(
//   width: constraints.maxWidth >=1920? 721 : constraints.maxWidth >= 820? 660: constraints.maxWidth >= 428 ? 346 : 200.sp
// )])

// ])


// constraints.maxWidth >=428 Column(children:[Text(),Image()]) : Row(children:[Text(),Image()])

// Wrap(children:[Text(),Image()])