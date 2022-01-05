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
  List<CarouselController> carousel_controllerList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadIfNull();
    pageController = new PageController(initialPage: widget.currentPosition);
    for (var item in widget.cat) {
      carousel_controllerList.add(CarouselController());
    }
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
              width: Device.width >= 900 ? 45.w : 90.w,
              height: 90.h,
              color: AppColor.mediumGrey,
              child: widget.cat[widget.currentPosition].loadFull
                  ? Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                controller: pageController,
                                onPageChanged: (index) {
                                  widget.currentPosition = index;
                                  carousel_controllerList[index].jumpToPage(0);
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
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  color: AppColor.white,
                                                  splashRadius: 20,
                                                  onPressed: () => Get.back(),
                                                  icon: Icon(Icons.close)),
                                              Expanded(
                                                child: Container(
                                                  child: Center(
                                                    child:
                                                        SingleChildScrollView(
                                                      reverse: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Text(
                                                        "Coach: ${widget.cat[now].codeCoach} | Coder: ${widget.cat[now].coderName}",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Raleway',
                                                            color:
                                                                AppColor.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.center,
                                                        // overflow:
                                                        //     TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
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
                                                                    .accentBlue,
                                                            child: Icon(Icons
                                                                .navigate_before_outlined),
                                                            heroTag: widget
                                                                    .cat[now]
                                                                    .hashCode +
                                                                1,
                                                            mini: true,
                                                            onPressed: () {
                                                              carousel_controllerList[
                                                                      now]
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
                                                    child:
                                                        CarouselSlider.builder(
                                                      options: CarouselOptions(
                                                          enableInfiniteScroll:
                                                              false,
                                                          onPageChanged:
                                                              (index, reason) {
                                                            currentIndex =
                                                                index;
                                                            setState(() {});
                                                          },
                                                          viewportFraction: 1),
                                                      carouselController:
                                                          carousel_controllerList[
                                                              now],
                                                      itemCount: widget
                                                          .cat[now]
                                                          .listOfProjects
                                                          .length,
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
                                                                    .accentBlue,
                                                            heroTag: widget
                                                                    .cat[now]
                                                                    .hashCode -
                                                                1,
                                                            mini: true,
                                                            child: Icon(Icons
                                                                .navigate_next_outlined),
                                                            onPressed: () {
                                                              carousel_controllerList[
                                                                      now]
                                                                  .nextPage();
                                                            })
                                                        : Container()),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              AnimatedSmoothIndicator(
                                                  effect: WormEffect(
                                                      dotWidth: 10,
                                                      dotHeight: 10,
                                                      activeDotColor:
                                                          AppColor.buttonGreen,
                                                      dotColor:
                                                          AppColor.lightGrey),
                                                  onDotClicked: (index) {
                                                    print(
                                                        " this is the current postion ${widget.currentPosition}");
                                                    print(
                                                        " this is the current index in ${widget.currentPosition}");
                                                    currentIndex = index;
                                                    carousel_controllerList[now]
                                                        .animateToPage(index);
                                                    setState(() {});
                                                  },
                                                  curve: Curves.easeIn,
                                                  activeIndex: currentIndex,
                                                  count: widget.cat[now]
                                                      .listOfProjects.length),
                                              Text(
                                                "${currentIndex + 1} of ${widget.cat[now].listOfProjects.length} projects",
                                                style: TextStyle(
                                                    fontFamily: 'Raleway',
                                                    color: AppColor.white,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        projTitle(
                                          widget
                                              .cat[widget.currentPosition]
                                              .listOfProjects[currentIndex]
                                              .title,
                                        ),
                                        SizedBox(
                                          height: 10,
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
                                                    .cat[widget.currentPosition]
                                                    .listOfProjects[
                                                        currentIndex]
                                                    .language),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                version(widget
                                                    .cat[widget.currentPosition]
                                                    .listOfProjects[
                                                        currentIndex]
                                                    .version),
                                              ],
                                            ),
                                            Spacer(),
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: int.parse(widget
                                                              .cat[widget
                                                                  .currentPosition]
                                                              .listOfProjects[
                                                                  currentIndex]
                                                              .status) /
                                                          100,
                                                      backgroundColor:
                                                          AppColor.black,
                                                      color:
                                                          AppColor.buttonGreen,
                                                    )),
                                                Text(
                                                    widget
                                                        .cat[widget
                                                            .currentPosition]
                                                        .listOfProjects[
                                                            currentIndex]
                                                        .status,
                                                    style: TextStyle(
                                                        fontFamily: 'Raleway',
                                                        color: AppColor.white))
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(.0),
                                              child: SizedBox(
                                                height: 55,
                                                width: 55,
                                                child: FloatingActionButton(
                                                  // disabledElevation: 0,
                                                  backgroundColor: Colors.white,
                                                  elevation: 5,
                                                  onPressed:
                                                      widget.cat[now].eligible
                                                          ? () {
                                                              Get.defaultDialog(
                                                                  radius: 10,
                                                                  cancel:
                                                                      RawMaterialButton(
                                                                    fillColor:
                                                                        AppColor
                                                                            .accentPurple,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              18.0),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                    },
                                                                    child: Text(
                                                                        "Cancel",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Raleway',
                                                                            color:
                                                                                AppColor.white)),
                                                                  ),
                                                                  confirm:
                                                                      RawMaterialButton(
                                                                    fillColor:
                                                                        AppColor
                                                                            .accentPurple,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              18.0),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      controller.updateLikedCategory(
                                                                          widget
                                                                              .cat[
                                                                                  now]
                                                                              .listOfProjects[
                                                                                  currentIndex]
                                                                              .identifier,
                                                                          widget
                                                                              .cat[now]
                                                                              .listOfProjects[currentIndex]
                                                                              .likedCategory);
                                                                      widget
                                                                          .cat[
                                                                              now]
                                                                          .listOfProjects[
                                                                              currentIndex]
                                                                          .liked = true;
                                                                      setState(
                                                                          () {});
                                                                      Get.back();
                                                                    },
                                                                    child: Text(
                                                                        "Ok",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Raleway',
                                                                            color:
                                                                                AppColor.white)),
                                                                  ),
                                                                  buttonColor:
                                                                      AppColor
                                                                          .accentPurple,
                                                                  barrierDismissible:
                                                                      false,
                                                                  onCancel:
                                                                      () {},
                                                                  onConfirm:
                                                                      () {},
                                                                  title:
                                                                      "Like this Project",
                                                                  titleStyle: TextStyle(
                                                                      fontFamily:
                                                                          'Raleway',
                                                                      color: AppColor
                                                                          .white),
                                                                  backgroundColor:
                                                                      AppColor
                                                                          .mediumGrey,
                                                                  titlePadding:
                                                                      EdgeInsets.only(
                                                                          top:
                                                                              20),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              20),
                                                                  content:
                                                                      Container(
                                                                    width: 200,
                                                                    height: 200,
                                                                    child: StatefulBuilder(builder:
                                                                        (context,
                                                                            _setState) {
                                                                      return Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          RadioListTile(
                                                                              activeColor: AppColor.buttonGreen,
                                                                              selected: widget.cat[now].listOfProjects[currentIndex].likedCategory == "Complexity",
                                                                              title: Text(
                                                                                "Complexity",
                                                                                style: TextStyle(fontFamily: 'Raleway', color: AppColor.white),
                                                                              ),
                                                                              value: "Complexity",
                                                                              groupValue: widget.cat[now].listOfProjects[currentIndex].likedCategory,
                                                                              onChanged: (value) => _setState(() {
                                                                                    widget.cat[now].listOfProjects[currentIndex].likedCategory = value;
                                                                                  })),
                                                                          RadioListTile(
                                                                            activeColor:
                                                                                AppColor.buttonGreen,
                                                                            selected:
                                                                                widget.cat[now].listOfProjects[currentIndex].likedCategory == "Fun",
                                                                            title:
                                                                                Text(
                                                                              "Fun",
                                                                              style: TextStyle(fontFamily: 'Raleway', color: AppColor.white),
                                                                            ),
                                                                            value:
                                                                                "Fun",
                                                                            groupValue:
                                                                                widget.cat[now].listOfProjects[currentIndex].likedCategory,
                                                                            onChanged:
                                                                                (value) {
                                                                              _setState(() {
                                                                                widget.cat[now].listOfProjects[currentIndex].likedCategory = value;
                                                                              });
                                                                            },
                                                                          ),
                                                                          RadioListTile(
                                                                              activeColor: AppColor.buttonGreen,
                                                                              selected: widget.cat[now].listOfProjects[currentIndex].likedCategory == "Creativity",
                                                                              title: Text(
                                                                                "Creativity",
                                                                                style: TextStyle(fontFamily: 'Raleway', color: AppColor.white),
                                                                              ),
                                                                              value: "Creativity",
                                                                              groupValue: widget.cat[now].listOfProjects[currentIndex].likedCategory,
                                                                              onChanged: (value) => _setState(() {
                                                                                    widget.cat[now].listOfProjects[currentIndex].likedCategory = value;
                                                                                  })),
                                                                        ],
                                                                      );
                                                                    }),
                                                                  ));
                                                            }
                                                          : null,
                                                  child: Icon(
                                                      widget
                                                              .cat[widget
                                                                  .currentPosition]
                                                              .listOfProjects[
                                                                  currentIndex]
                                                              .liked
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_outline_outlined,
                                                      color:
                                                          AppColor.buttonGreen),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Description:',
                                            style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 16,
                                              color: AppColor.white,
                                            )),
                                        description(
                                          widget
                                              .cat[widget.currentPosition]
                                              .listOfProjects[currentIndex]
                                              .description,
                                        ),
                                        SizedBox(height: 20),
                                        if (!widget.cat[widget.currentPosition]
                                            .eligible)
                                          Text(
                                            "NOTE: ${widget.cat[widget.currentPosition].listOfProjects[currentIndex].coderName} started after October 1, 2021, we cant wait to see what they will code for the next CoderFair",
                                            style: TextStyle(
                                              fontFamily: 'Raleway',
                                              color: Colors.red,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
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
                                if (widget.currentPosition != 0)
                                  RawMaterialButton(
                                      fillColor: AppColor.accentPurple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      onPressed: () {
                                        currentIndex = 0;

                                        pageController.previousPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeIn);
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: SizedBox(
                                          child: Text("Prev coder",
                                              style: TextStyle(
                                                  color: AppColor.white,
                                                  fontFamily: 'Raleway')),
                                        ),
                                      )),
                                if (widget.currentPosition !=
                                    widget.cat.length - 1)
                                  RawMaterialButton(
                                      fillColor: AppColor.accentPurple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      onPressed: () {
                                        currentIndex = 0;

                                        pageController.nextPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeIn);

                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: SizedBox(
                                          child: Text("Next coder",
                                              style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  color: AppColor.white)),
                                        ),
                                      ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: AppColor.white),
    );
  }

  version(version) {
    return Text(
      'Version: $version',
      style: TextStyle(
        fontSize: 16,
        color: AppColor.white,
        fontFamily: 'Raleway',
      ),
    );
  }

  language(language) {
    return Text(
      'Language: $language',
      style: TextStyle(
        fontSize: 16,
        color: AppColor.yellow,
        fontFamily: 'Raleway',
      ),
    );
  }

  description(desc) {
    ScrollController scrollController = ScrollController();

    return Expanded(
      child: Theme(
        data: Theme.of(context).copyWith(
            scrollbarTheme: ScrollbarThemeData(
                isAlwaysShown: true,
                trackColor: MaterialStateProperty.all(AppColor.buttonGreen))),
        child: Scrollbar(
          controller: scrollController,
          isAlwaysShown: true,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              margin: EdgeInsets.only(right: 15, top: 10),
              child: Text(
                '$desc',
                overflow: TextOverflow.clip,
                style: TextStyle(
                    height: 1.3,
                    fontSize: 16,
                    color: AppColor.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

// TODO: change colors primary
