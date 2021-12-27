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
  var cat;
  int currentPosition;
  CardScreen(
      {required this.student,
      required this.categoryName,
      required this.cat,
      required this.currentPosition})
      : _caroController = CarouselController();

  CarouselController _caroController;

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  var currentIndex = 0;
  List<VideoPlayerController> video_player_controllerList = [];
  List<ChewieController> chewieControllerList = [];
  late HomeScreenController controller;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadIfNull();
    print(widget.categoryName);
    pageController = new PageController(initialPage: widget.currentPosition);
  }

  loadIfNull() async {
    controller = Get.find();
    if (!widget.cat[widget.currentPosition].loadFull) {
      widget.cat[widget.currentPosition] = await controller.loadAndReturn(
          widget.categoryName, widget.cat[widget.currentPosition]);
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
              child: widget.cat[widget.currentPosition].loadFull
                  ? Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              controller: pageController,
                              onPageChanged: (index) {
                                widget.cat[index].seen = true;
                                controller
                                    .addToSeen(widget.cat[index].coderName);

                                controller.paginateStudents(
                                    (index),
                                    controller.categories.keys.toList()[
                                        controller.categories.keys
                                            .toList()
                                            .indexOf(widget.categoryName)]);
                                setState(() {});
                              },
                              itemCount: widget.cat.length,
                              itemBuilder: (context, now) {
                                return Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 15.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                                splashRadius: 20,
                                                onPressed: () => Get.back(),
                                                icon: Icon(Icons.close)),
                                            Text(
                                                "coach: ${widget.cat[now].codeCoach}"),
                                            Text(
                                                "coder: ${widget.cat[now].coderName}"),
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  widget.cat[now]
                                                      .profilePictureURL),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            if (Device.width >= 900)
                                              Flexible(
                                                  flex: 1,
                                                  child: (widget
                                                              .cat[now]
                                                              .listOfProjects
                                                              .length >
                                                          1)
                                                      ? FloatingActionButton(
                                                          backgroundColor:
                                                              AppColor
                                                                  .buttonGreen,
                                                          child: Icon(Icons
                                                              .navigate_before_outlined),
                                                          heroTag: widget
                                                                  .cat[now]
                                                                  .hashCode +
                                                              1,
                                                          mini: true,
                                                          onPressed: () {
                                                            widget
                                                                ._caroController
                                                                .previousPage();
                                                          })
                                                      : Container()),
                                            Flexible(
                                              flex: 6,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: AspectRatio(
                                                  aspectRatio: 16 / 9,
                                                  child: CarouselSlider.builder(
                                                    options: CarouselOptions(
                                                        enableInfiniteScroll:
                                                            false,
                                                        onPageChanged:
                                                            (index, reason) {
                                                          currentIndex = index;
                                                          setState(() {});
                                                        },
                                                        viewportFraction: 1),
                                                    carouselController:
                                                        widget._caroController,
                                                    itemCount: widget.student
                                                        .listOfProjects.length,
                                                    itemBuilder: (context,
                                                        index, realIndex) {
                                                      return CustomVideo(
                                                        videoId: widget
                                                            .cat[now]
                                                            .listOfProjects[
                                                                index]
                                                            .videoURL,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (Device.width >= 900)
                                              Flexible(
                                                  flex: 1,
                                                  child: (widget
                                                              .cat[now]
                                                              .listOfProjects
                                                              .length >
                                                          1)
                                                      ? FloatingActionButton(
                                                          backgroundColor:
                                                              AppColor
                                                                  .buttonGreen,
                                                          heroTag: widget
                                                                  .cat[now]
                                                                  .hashCode -
                                                              1,
                                                          mini: true,
                                                          child: Icon(Icons
                                                              .navigate_next_outlined),
                                                          onPressed: () {
                                                            widget
                                                                ._caroController
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AnimatedSmoothIndicator(
                                                effect: WormEffect(
                                                    activeDotColor:
                                                        AppColor.buttonGreen,
                                                    dotColor: Colors.grey),
                                                onDotClicked: (index) {
                                                  currentIndex = index;
                                                  widget._caroController
                                                      .animateToPage(index);
                                                  setState(() {});
                                                },
                                                curve: Curves.easeIn,
                                                activeIndex: currentIndex,
                                                count: widget.student
                                                    .listOfProjects.length),
                                            Text(
                                                "${currentIndex + 1} of ${widget.cat[now].listOfProjects.length} projects")
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      projTitle(
                                        widget.student
                                            .listOfProjects[currentIndex].title,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              language(widget
                                                  .student
                                                  .listOfProjects[currentIndex]
                                                  .language),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              version(widget
                                                  .student
                                                  .listOfProjects[currentIndex]
                                                  .version),
                                            ],
                                          ),
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CircularProgressIndicator(
                                                value: int.parse(widget
                                                        .student
                                                        .listOfProjects[
                                                            currentIndex]
                                                        .status) /
                                                    100,
                                                backgroundColor: Colors.grey,
                                                color: Colors.green,
                                              ),
                                              Text(widget
                                                  .student
                                                  .listOfProjects[currentIndex]
                                                  .status)
                                            ],
                                          ),
                                          FloatingActionButton(
                                            backgroundColor: Colors.white,
                                            elevation: 10,
                                            onPressed: () {
                                              Get.defaultDialog(
                                                  barrierDismissible: false,
                                                  onCancel: () {},
                                                  onConfirm: () {
                                                    controller
                                                        .updateLikedCategory(
                                                            widget
                                                                .student
                                                                .listOfProjects[
                                                                    currentIndex]
                                                                .identifier,
                                                            widget
                                                                .student
                                                                .listOfProjects[
                                                                    currentIndex]
                                                                .likedCategory);
                                                    widget
                                                        .student
                                                        .listOfProjects[
                                                            currentIndex]
                                                        .liked = true;
                                                    setState(() {});
                                                    Get.back();
                                                  },
                                                  title: "Like this Project",
                                                  backgroundColor: Colors.white,
                                                  content: Container(
                                                    width: 200,
                                                    height: 200,
                                                    child: StatefulBuilder(
                                                        builder: (context,
                                                            _setState) {
                                                      return Column(
                                                        children: [
                                                          RadioListTile(
                                                              selected: widget
                                                                      .student
                                                                      .listOfProjects[
                                                                          currentIndex]
                                                                      .likedCategory ==
                                                                  "complexity",
                                                              tileColor:
                                                                  Colors.white,
                                                              title: Text(
                                                                "complexity",
                                                              ),
                                                              value:
                                                                  "complexity",
                                                              groupValue: widget
                                                                  .student
                                                                  .listOfProjects[
                                                                      currentIndex]
                                                                  .likedCategory,
                                                              onChanged:
                                                                  (value) =>
                                                                      _setState(
                                                                          () {
                                                                        widget
                                                                            .student
                                                                            .listOfProjects[currentIndex]
                                                                            .likedCategory = value;
                                                                      })),
                                                          RadioListTile(
                                                            selected: widget
                                                                    .student
                                                                    .listOfProjects[
                                                                        currentIndex]
                                                                    .likedCategory ==
                                                                "fun",
                                                            tileColor:
                                                                Colors.white,
                                                            title: Text(
                                                              "fun",
                                                            ),
                                                            value: "fun",
                                                            groupValue: widget
                                                                .student
                                                                .listOfProjects[
                                                                    currentIndex]
                                                                .likedCategory,
                                                            onChanged: (value) {
                                                              _setState(() {
                                                                widget
                                                                    .student
                                                                    .listOfProjects[
                                                                        currentIndex]
                                                                    .likedCategory = value;
                                                              });
                                                            },
                                                          ),
                                                          RadioListTile(
                                                              activeColor:
                                                                  Colors.red,
                                                              selected: widget
                                                                      .student
                                                                      .listOfProjects[
                                                                          currentIndex]
                                                                      .likedCategory ==
                                                                  "creativity",
                                                              tileColor:
                                                                  Colors.white,
                                                              title: Text(
                                                                "creativity",
                                                              ),
                                                              value:
                                                                  "creativity",
                                                              groupValue: widget
                                                                  .student
                                                                  .listOfProjects[
                                                                      currentIndex]
                                                                  .likedCategory,
                                                              onChanged:
                                                                  (value) =>
                                                                      _setState(
                                                                          () {
                                                                        widget
                                                                            .student
                                                                            .listOfProjects[currentIndex]
                                                                            .likedCategory = value;
                                                                      })),
                                                        ],
                                                      );
                                                    }),
                                                  ));
                                            },
                                            child: Icon(
                                                widget
                                                        .student
                                                        .listOfProjects[
                                                            currentIndex]
                                                        .liked
                                                    ? Icons.favorite
                                                    : Icons
                                                        .favorite_outline_outlined,
                                                color: AppColor.buttonGreen),
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
                                        widget
                                            .cat[now]
                                            .listOfProjects[currentIndex]
                                            .description,
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              widget.currentPosition != 0
                                  ? TextButton(
                                      onPressed: () {
                                        widget.currentPosition -= 1;

                                        pageController.previousPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeIn);
                                      },
                                      child: Text("Prev coder"))
                                  : Container(),
                              widget.currentPosition != widget.cat.length - 1
                                  ? TextButton(
                                      onPressed: () {
                                        widget.currentPosition += 1;
                                        pageController.nextPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeIn);
                                      },
                                      child: Text("Next coder"))
                                  : Container()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
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

// TODO: change colors primary
