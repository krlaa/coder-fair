import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:coder_fair/models/project_model.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'card_screen.dart';

// TODO: Add overlay screen for onboarding

class HomeScreen extends GetView<HomeScreenController> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          body: SafeArea(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.sp),
          child: Row(
            children: [
              Flexible(
                  flex: 4,
                  child: Obx(() {
                    if (!controller.loadingStudentNames) {
                      return Scrollbar(
                        isAlwaysShown: true,
                        showTrackOnHover: true,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: controller.categories.length,
                          itemBuilder: (context, index2) {
                            var cat =
                                controller.categories.values.toList()[index2];
                            return Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                          '${controller.categories.keys.toList()[index2]}'),
                                      CarouselSlider.builder(
                                          carouselController: controller
                                              .listOfControllers[index2],
                                          itemCount: cat.length,
                                          itemBuilder:
                                              (context, index1, realIndex) {
                                            return InkWell(
                                              onTap: () {
                                                controller.currentCategory =
                                                    controller.categories.keys
                                                        .toList()[index2];
                                                Get.to(
                                                    CardScreen(
                                                      student: controller
                                                                  .categories[
                                                              controller
                                                                  .currentCategory]
                                                          [index1],
                                                    ),
                                                    transition: Transition.size,
                                                    curve: Curves.easeInOut,
                                                    opaque: false);
                                              },
                                              child: Card(
                                                elevation: 8,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Center(
                                                      child: Text(
                                                          cat[index1] is Student
                                                              ? cat[index1]
                                                                  .coderName
                                                              : cat[index1])),
                                                ),
                                              ),
                                            );
                                          },
                                          options: CarouselOptions(
                                              scrollPhysics:
                                                  CustomPageViewScrollPhysics(),
                                              pageSnapping: true,
                                              onPageChanged: (index, reason) {
                                                controller.currentCategory =
                                                    controller.categories.keys
                                                        .toList()[index2];
                                                controller.currentIndex = index;

                                                controller.paginateStudents(
                                                    index,
                                                    controller.categories.keys
                                                        .toList()[index2]);
                                              },
                                              viewportFraction: 0.3,
                                              scrollDirection: Axis.vertical,
                                              height: 200,
                                              initialPage: 0,
                                              enlargeCenterPage: true,
                                              enableInfiniteScroll: false)),
                                    ],
                                  ),
                                ),
                                FloatingActionButton(onPressed: () {
                                  CarouselController x =
                                      controller.listOfControllers[index2];
                                  x.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.linear);
                                })
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.white,
                      ));
                    }
                  })),
            ],
          ),
        ),
      ));
    });
  }
}

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    final tolerance = this.tolerance;
    if ((velocity.abs() < tolerance.velocity) ||
        (velocity > 0.0 && position.pixels >= position.maxScrollExtent) ||
        (velocity < 0.0 && position.pixels <= position.minScrollExtent)) {
      return null;
    }
    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      friction: 1000, // <--- HERE
      tolerance: tolerance,
    );
  }
}
