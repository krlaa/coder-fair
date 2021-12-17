import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CardScreen extends GetView<HomeScreenController> {
  final Student student;
  CardScreen({required this.student});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Center(
          child: Container(
              width: Device.width >= 900 ? 40.w : 90.w,
              height: 90.h,
              color: Colors.green,
              child: !controller.loadingStudentInfo
                  ? Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text("${student}"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                    flex: 1,
                                    child: FloatingActionButton(
                                        heroTag: student.hashCode + 1,
                                        mini: true,
                                        onPressed: () {
                                          controller.cardListController
                                              .previousPage();
                                        })),
                                Flexible(
                                  flex: 6,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: CarouselSlider.builder(
                                        options: CarouselOptions(
                                            viewportFraction: 1),
                                        carouselController:
                                            controller.cardListController,
                                        itemCount:
                                            student.listOfProjects.length,
                                        itemBuilder:
                                            (context, index, realIndex) {
                                          var x = YoutubePlayerController(
                                              initialVideoId:
                                                  YoutubePlayerController
                                                      .convertUrlToId(student
                                                          .listOfProjects[index]
                                                          .videoURL)!);
                                          return YoutubePlayerControllerProvider(
                                            // Provides controller to all the widget below it.
                                            controller: x,
                                            child: YoutubeValueBuilder(
                                                builder: (context, value) {
                                              return YoutubePlayerIFrame(
                                                key: Key(student
                                                    .listOfProjects[index]
                                                    .videoURL),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                    flex: 1,
                                    child: FloatingActionButton(
                                        heroTag: student.hashCode - 1,
                                        mini: true,
                                        onPressed: () {
                                          controller.cardListController
                                              .nextPage();
                                        })),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )),
        ));
  }
}
