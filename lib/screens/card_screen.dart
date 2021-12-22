// ignore_for_file: duplicate_import

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:coder_fair/constants/app_colors.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:coder_fair/widgets/customVideo.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CardScreen extends StatefulWidget {
  Student student;
  String categoryName;
  CardScreen({required this.student, required this.categoryName})
      : _caroController = CarouselController();

  CarouselController _caroController;

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  var currentIndex = 0;
  List<VideoPlayerController> video_player_controllerList = [];
  List<ChewieController> chewieControllerList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadIfNull();
  }

  loadIfNull() async {
    HomeScreenController controller = Get.find();
    if (!widget.student.loadFull) {
      widget.student =
          await controller.loadAndReturn(widget.categoryName, widget.student);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Center(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              width: Device.width >= 900 ? 35.w : 90.w,
              height: 90.h,
              color: Colors.white,
              child: widget.student.loadFull
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    splashRadius: 20,
                                    onPressed: () => Get.back(),
                                    icon: Icon(Icons.close)),
                                Text("coach: ${widget.student.codeCoach}"),
                                Text("coder: ${widget.student.coderName}"),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      widget.student.profilePictureURL),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (Device.width >= 900)
                                  Flexible(
                                      flex: 1,
                                      child: (widget.student.listOfProjects
                                                  .length >
                                              1)
                                          ? FloatingActionButton(
                                              backgroundColor: buttonGreen,
                                              child: Icon(Icons
                                                  .navigate_before_outlined),
                                              heroTag:
                                                  widget.student.hashCode + 1,
                                              mini: true,
                                              onPressed: () {
                                                widget._caroController
                                                    .previousPage();
                                              })
                                          : Container()),
                                Flexible(
                                  flex: 6,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: CarouselSlider.builder(
                                        options: CarouselOptions(
                                            enableInfiniteScroll: false,
                                            onPageChanged: (index, reason) {
                                              print(reason);
                                              currentIndex = index;
                                              setState(() {});
                                            },
                                            viewportFraction: 1),
                                        carouselController:
                                            widget._caroController,
                                        itemCount: widget
                                            .student.listOfProjects.length,
                                        itemBuilder:
                                            (context, index, realIndex) {
                                          return CustomVideo(
                                            videoId: widget.student
                                                .listOfProjects[index].videoURL,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                if (Device.width >= 900)
                                  Flexible(
                                      flex: 1,
                                      child: (widget.student.listOfProjects
                                                  .length >
                                              1)
                                          ? FloatingActionButton(
                                              backgroundColor: buttonGreen,
                                              heroTag:
                                                  widget.student.hashCode - 1,
                                              mini: true,
                                              child: Icon(
                                                  Icons.navigate_next_outlined),
                                              onPressed: () {
                                                widget._caroController
                                                    .nextPage();
                                              })
                                          : Container()),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AnimatedSmoothIndicator(
                                    effect: WormEffect(
                                        activeDotColor: buttonGreen,
                                        dotColor: Colors.grey),
                                    onDotClicked: (index) {
                                      currentIndex = index;
                                      widget._caroController
                                          .animateToPage(index);
                                      setState(() {});
                                    },
                                    curve: Curves.easeIn,
                                    activeIndex: currentIndex,
                                    count:
                                        widget.student.listOfProjects.length),
                                Text(
                                    "${currentIndex + 1} of ${widget.student.listOfProjects.length} projects")
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          projTitle(
                            widget.student.listOfProjects[currentIndex].title,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  language(widget.student
                                      .listOfProjects[currentIndex].language),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  version(widget.student
                                      .listOfProjects[currentIndex].version),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    value: int.parse(widget
                                            .student
                                            .listOfProjects[currentIndex]
                                            .status) /
                                        100,
                                    backgroundColor: Colors.grey,
                                    color: Colors.green,
                                  ),
                                  Text(widget.student
                                      .listOfProjects[currentIndex].status)
                                ],
                              ),
                              FloatingActionButton(
                                backgroundColor: Colors.white,
                                elevation: 10,
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: "Like this Project",
                                      backgroundColor: Colors.white,
                                      content: Container(
                                        width: 200,
                                        height: 200,
                                        child: Column(
                                          children: [
                                            RadioListTile(
                                              tileColor: Colors.white,
                                              title: Text(
                                                "complexity",
                                              ),
                                              value: "complexity",
                                              groupValue: 1,
                                              onChanged: (value) {},
                                            ),
                                            RadioListTile(
                                              tileColor: Colors.white,
                                              title: Text(
                                                "fun",
                                              ),
                                              value: "fun",
                                              groupValue: 1,
                                              onChanged: (value) {},
                                            ),
                                            RadioListTile(
                                              tileColor: Colors.white,
                                              title: Text(
                                                "creativity",
                                              ),
                                              value: "creativity",
                                              groupValue: 1,
                                              onChanged: (value) {},
                                            )
                                          ],
                                        ),
                                      ));
                                },
                                child: Icon(Icons.favorite, color: buttonGreen),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Description:',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          description(
                            widget.student.listOfProjects[currentIndex]
                                .description,
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Text("Prev coder")),
                                TextButton(
                                    onPressed: () {}, child: Text("Next coder"))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  : Center(child: CircularProgressIndicator())),
        )));
  }

  projTitle(title) {
    return Text(
      title,
      style: TextStyle(
          fontFamily: 'RobotoSlab',
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black),
    );
  }

  version(version) {
    return Text(
      'Version: $version',
      style: TextStyle(fontSize: 16, color: Colors.black),
    );
  }

  language(language) {
    return Text(
      'Language: $language',
      style: TextStyle(fontSize: 16, color: Colors.black),
    );
  }

  description(desc) {
    return Text(
      '$desc',
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
