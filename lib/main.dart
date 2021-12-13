import 'package:coder_fair/screens/home_screen.dart';
import 'package:coder_fair/screens/home_screen_backup.dart';
import 'package:coder_fair/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'constants/app_colors.dart';
import 'controllers/home_screen_controller.dart';
import 'controllers/login_screen_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future<Box> openHiveBox(String boxName) async {
    if (!kIsWeb && !Hive.isBoxOpen(boxName))
      Hive.init((await getApplicationDocumentsDirectory()).path);

    return await Hive.openBox(boxName);
  }

  var box = await openHiveBox('userPreferences');

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
        scrollBehavior: AppScrollBehavior(),
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

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
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