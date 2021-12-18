import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/constants/extenstions.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:coder_fair/screens/stacked_card_carousel.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CardScreen extends GetView<HomeScreenController> {
  final Student student;
  CardScreen({required this.student})
      : d = PageController(
            initialPage: student.listOfProjects.length, keepPage: true);

  var d;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Center(
          child: Container(
              // width: Device.width >= 900 ? 35.w : 90.w,
              height: 90.h,
              color: Colors.green,
              child: !controller.loadingStudentInfo
                  ? Column(
                      children: [
                        Text("${student}"),
                        Expanded(
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: StackedCardCarousel(
                                pageController: d,
                                items: student.listOfProjects
                                    .asMap()
                                    .entries
                                    .map((e) => ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: Image.network(
                                                e.value.videoURL
                                                    .getThumbnailFromUrl(),
                                                fit: BoxFit.cover,
                                              )),
                                        ))
                                    .toList()
                                    .reversed
                                    .toList()),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )),
        ));
  }
}
