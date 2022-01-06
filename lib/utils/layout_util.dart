import 'package:coder_fair/screens/home_screen.dart';
import 'package:coder_fair/screens/mobile_home_screen.dart';
import 'package:coder_fair/widgets/summer_camp_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdaptiveHomeScreen extends StatelessWidget {
  const AdaptiveHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1000) {
            return HomeScreen();
          } else {
            return MobileHomeScreen();
          }
        },
      ),
    );
  }
}
