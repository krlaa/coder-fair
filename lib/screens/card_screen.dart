import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CardScreen extends GetView<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 15.0,
            sigmaY: 15.0,
          ),
          child: Center(
            child: Container(
                width: MediaQuery.of(context).size.width >= 1200 ? 40.w : 90.w,
                height: 90.h,
                color: Colors.green,
                child: !controller.loadingStudentInfo
                    ? Scrollbar(
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text("${controller.currentStudent}"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                      flex: 1,
                                      child: FloatingActionButton(
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
                                          itemCount: controller.currentStudent
                                              .listOfProjects.length,
                                          itemBuilder:
                                              (context, index, realIndex) {
                                            var x = YoutubePlayerController(
                                                initialVideoId:
                                                    YoutubePlayerController
                                                        .convertUrlToId(
                                                            controller
                                                                .currentStudent
                                                                .listOfProjects[
                                                                    index]
                                                                .videoURL)!);
                                            return YoutubePlayerControllerProvider(
                                              // Provides controller to all the widget below it.
                                              controller: x,
                                              child: YoutubePlayerIFrame(
                                                key: Key(controller
                                                    .currentStudent
                                                    .listOfProjects[index]
                                                    .videoURL),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: FloatingActionButton(
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
          ),
        ));
  }
}
