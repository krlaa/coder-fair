import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:coder_fair/models/project_model.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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
                                            return Material(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              elevation: 8,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Center(
                                                    child: Text(cat[index1]
                                                            is Student
                                                        ? cat[index1].coderName
                                                        : cat[index1])),
                                              ),
                                            );
                                          },
                                          options: CarouselOptions(
                                              scrollPhysics:
                                                  CustomPageViewScrollPhysics(),
                                              pageSnapping: true,
                                              onPageChanged: (index, reason) {
                                                controller.x =
                                                    YoutubePlayerController(
                                                  initialVideoId:
                                                      YoutubePlayerController
                                                          .convertUrlToId(
                                                              "${controller.currentStudent.listOfProjects[0].videoURL}")!,
                                                  params: YoutubePlayerParams(
                                                    startAt: const Duration(
                                                        minutes: 1,
                                                        seconds: 36),
                                                    showControls: true,
                                                    showFullscreenButton: true,
                                                    desktopMode: false,
                                                    enableJavaScript: true,
                                                    autoPlay: true,
                                                    privacyEnhanced: true,
                                                    useHybridComposition: true,
                                                  ),
                                                );
                                                controller.currentCategory =
                                                    controller.categories.keys
                                                        .toList()[index2];
                                                controller.currentIndex = index;
                                                // if (controller.currentValue
                                                //             .value +
                                                //         2 <
                                                //     index) {
                                                //   CarouselController x =
                                                //       controller
                                                //               .listOfControllers[
                                                //           index2];
                                                //   x.jumpToPage(controller
                                                //           .currentValue
                                                //           .value +
                                                //       2);
                                                //   controller.currentValue
                                                //       .value = controller
                                                //           .currentValue
                                                //           .value +
                                                //       2;
                                                // } else if (controller
                                                //             .currentValue
                                                //             .value +
                                                //         2 ==
                                                //     index) {
                                                //   controller.currentValue
                                                //       .value = index;
                                                // }
                                                controller.paginateStudents(
                                                    index,
                                                    controller.categories.keys
                                                        .toList()[index2]);
                                                print(controller.categories.keys
                                                        .toList()[index2] ==
                                                    controller.currentCategory);
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
              if (constraints.maxWidth > 1250)
                Flexible(
                  flex: 3,
                  child: Obx(() {
                    print(controller.currentStudent.listOfProjects);

                    return Container(
                        color: Colors.green,
                        child: !controller.loadingStudentInfo
                            ? YoutubePlayerControllerProvider(
                                // Provides controller to all the widget below it.
                                controller: controller.x,
                                child: Column(
                                  children: [
                                    Text("${controller.currentStudent}"),
                                    YoutubePlayerIFrame(
                                      key: Key(
                                          controller.currentStudent.coderName),
                                      controller: controller.x,
                                    ),
                                    Positioned.fill(
                                      child: YoutubeValueBuilder(
                                        controller: controller.x,
                                        builder: (context, value) {
                                          return Material(
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    YoutubePlayerController
                                                        .getThumbnail(
                                                      videoId: controller
                                                          .x.initialVideoId,
                                                      quality: ThumbnailQuality
                                                          .medium,
                                                    ),
                                                  ),
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ))
                            : Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ));
                  }),
                )
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

  // @override
  // SpringDescription get spring => const SpringDescription(
  //       mass: 1000,
  //       stiffness: 100,
  //       damping: 500,
  //     );
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
