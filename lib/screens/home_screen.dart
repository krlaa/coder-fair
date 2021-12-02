import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HomeScreen extends GetView<HomeScreenController> {
  @override
  Widget build(
    BuildContext context,
  ) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'K18cpp_-gP8',
      params: YoutubePlayerParams(
        autoPlay: true,
        showControls: false,
        showFullscreenButton: true,
      ),
    );
    return LayoutBuilder(builder: (context, constraints) {
      print(controller.categories);
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => controller.changeExpanded(true),
          ),
          body: SafeArea(
            child: DefaultTextStyle(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.sp),
              child: Row(
                children: [
                  Flexible(
                      flex: 4,
                      child: Obx(() {
                        if (!controller.loadingStudentNames.value) {
                          return Scrollbar(
                            isAlwaysShown: true,
                            showTrackOnHover: true,
                            child: ListView.builder(
                              itemCount: controller.categories.length,
                              itemBuilder: (context, index) {
                                var cat = controller.categories.values
                                    .toList()[index];
                                print(controller
                                    .listOfControllers[index].hashCode);
                                return Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        children: [
                                          Text(
                                              '${controller.categories.keys.toList()[index]}'),
                                          CarouselSlider.builder(
                                              carouselController: controller
                                                  .listOfControllers[index],
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
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Center(
                                                        child:
                                                            Text(cat[index1])),
                                                  ),
                                                );
                                              },
                                              options: CarouselOptions(
                                                  onPageChanged:
                                                      (index, reason) {
                                                    controller.loadStudent(
                                                        cat[index]);
                                                  },
                                                  viewportFraction: 0.3,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  height: 200,
                                                  initialPage: 0,
                                                  enlargeCenterPage: true,
                                                  enableInfiniteScroll:
                                                      cat.length > 2)),
                                        ],
                                      ),
                                    ),
                                    FloatingActionButton(onPressed: () {
                                      CarouselController x =
                                          controller.listOfControllers[index];
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
                        child: Expanded(
                          child: Obx(
                            () => Container(
                                color: Colors.green,
                                child: !controller.loadingStudentInfo.value
                                    ? Column(
                                        children: [
                                          Text(
                                              "${controller.currentStudent.value.codeCoach}"),
                                          YoutubePlayerControllerProvider(
                                              // Provides controller to all the widget below it.
                                              controller: _controller,
                                              child: YoutubePlayerIFrame(
                                                controller: _controller,
                                                aspectRatio: 16 / 15,
                                              )),
                                          YoutubePlayerControllerProvider(
                                              // Provides controller to all the widget below it.
                                              controller: _controller,
                                              child: YoutubeValueBuilder(
                                                controller:
                                                    _controller, // This can be omitted, if using `YoutubePlayerControllerProvider`
                                                builder: (context, value) {
                                                  return IconButton(
                                                    icon: Icon(
                                                      value.playerState ==
                                                              PlayerState
                                                                  .playing
                                                          ? Icons.pause
                                                          : Icons.play_arrow,
                                                    ),
                                                    onPressed: value.isReady
                                                        ? () {
                                                            context.ytController
                                                                .play();
                                                            value.playerState ==
                                                                    PlayerState
                                                                        .playing
                                                                ? context
                                                                    .ytController
                                                                    .pause()
                                                                : context
                                                                    .ytController
                                                                    .play();
                                                          }
                                                        : null,
                                                  );
                                                },
                                              ))
                                        ],
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )),
                          ),
                        ))
                ],
              ),
            ),
          ));
    });
  }
}
