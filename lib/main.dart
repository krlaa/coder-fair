import 'package:flutter/material.dart';

import 'constants/app_colors.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: mainBg),
      title: 'TCS Tampa CF',
      home: LoginScreen(),
    );
  }
}
