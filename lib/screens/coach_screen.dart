import 'package:coder_fair/controllers/coach_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachScreen extends GetView<CoachScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      child: Column(
        children: [
          TextFormField(),
          TextFormField(),
          TextFormField(),
          TextFormField(),
        ],
      ),
    ));
  }
}
