import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/constants/app_colors.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:coder_fair/controllers/login_screen_controller.dart';
import 'package:coder_fair/screens/card_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CarouselBuilderWithIndicator extends StatefulWidget {
  var cat;
  var categoryName;

  CarouselBuilderWithIndicator({
    required this.cat,
    required this.categoryName,
    Key? key,
  }) : super(key: key);

  @override
  State<CarouselBuilderWithIndicator> createState() =>
      _CarouselBuilderWithIndicatorState();
}

class _CarouselBuilderWithIndicatorState
    extends State<CarouselBuilderWithIndicator>
    with AutomaticKeepAliveClientMixin {
  CarouselController carouselController = CarouselController();
  late HomeScreenController controller;
  late LoginScreenController loginState;
  Map listOfSeen = {};
  int _index = 0;
  bool get wantKeepAlive => true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.find();
    loginState = Get.find();
    var box = Hive.box('userPreferences');
    listOfSeen = box.get('listOfSeen');
  }

  @override
  void didUpdateWidget(covariant CarouselBuilderWithIndicator oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _index = 0;
    updateScrollPosition();
    setState(() {});
  }

  void updateScrollPosition() async {
    await carouselController.onReady;
    if (!widget.cat.isEmpty) carouselController.animateToPage(0);
  }
// entry.value = a student object

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        child: widget.cat.isEmpty
            ? Center(
                child: Text("Nothing here"),
              )
            : Row(
                // TODO: In this row add the two widgets for the side and set the visibility with if statement Device.width>=1920
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                      flex: 1,
                      child: Container(
                        width: 60,
                        child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            child: _index != 0
                                ? FloatingActionButton(
                                    backgroundColor: AppColor.accentBlue,
                                    child: RotatedBox(
                                        quarterTurns: 1,
                                        child: Icon(
                                            Icons.navigate_before_outlined)),
                                    mini: true,
                                    onPressed: () {
                                      carouselController.previousPage();
                                    },
                                  )
                                : Container()),
                      )),
                  Flexible(
                    flex: 5,
                    child: SizedBox(
                      child: Scrollbar(
                        controller: scrollController,
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          reverse: true,
                          child: CarouselSlider.builder(
                              carouselController: carouselController,
                              itemCount:
                                  widget.cat.asMap().entries.toList().length,
                              itemBuilder: (context, index, realIndex) {
                                var entry =
                                    widget.cat.asMap().entries.toList()[index];

                                return Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        // margin: EdgeInsets.symmetric(vertical: 30),
                                        child: InkWell(
                                          onTap: () {
                                            if (_index == entry.key) {
                                              widget.cat[_index].seen = true;
                                              controller.addToSeen(
                                                  widget.cat[_index].coderName);
                                              setState(() {});
                                              Get.dialog(ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    height: 90.h,
                                                    child: CardScreen(
                                                        student: entry.value,
                                                        categoryName:
                                                            widget.categoryName,
                                                        cat: widget.cat,
                                                        currentPosition:
                                                            _index),
                                                  )));
                                            }
                                          },
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Material(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColor.black,
                                                  // elevation: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: AspectRatio(
                                                      aspectRatio: 16 / 9,
                                                      child: SizedBox(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Center(
                                                              child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left: 5,
                                                                        top:
                                                                            10),
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          35,
                                                                      foregroundImage:
                                                                          NetworkImage(
                                                                        entry
                                                                            .value
                                                                            .profilePictureURL,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Image.asset(
                                                                    'images/tcs-logo-white.png',
                                                                    width: 100,
                                                                    height: 50,
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  FittedBox(
                                                                    fit: BoxFit
                                                                        .fitHeight,
                                                                    child: Icon(
                                                                      entry.value.seen ||
                                                                              listOfSeen.containsKey(entry
                                                                                  .value.coderName)
                                                                          ? Icons
                                                                              .visibility
                                                                          : Icons
                                                                              .visibility_off,
                                                                      color: AppColor
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                loginState
                                                                        .currentUser
                                                                        .coders
                                                                        .contains(entry
                                                                            .value
                                                                            .coderName)
                                                                    ? entry
                                                                        .value
                                                                        .first_name
                                                                    : entry
                                                                        .value
                                                                        .coderName,
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .white,
                                                                    fontFamily:
                                                                        'Raleway'),
                                                              ),
                                                            ],
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                              ClipRRect(
                                                child: BackdropFilter(
                                                  child: AspectRatio(
                                                      aspectRatio: 16 / 9,
                                                      child: Container()),
                                                  filter: ImageFilter.blur(
                                                      sigmaX:
                                                          entry.key == _index
                                                              ? 0.001
                                                              : 4,
                                                      sigmaY:
                                                          entry.key == _index
                                                              ? 0.001
                                                              : 4),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              options: CarouselOptions(
                                  onScrolled: (value) {
                                    scrollController.jumpTo(scrollController
                                            .position.maxScrollExtent /
                                        2);
                                  },
                                  enableInfiniteScroll: false,
                                  viewportFraction: 0.38,
                                  height: 500,
                                  scrollPhysics: const ClampingScrollPhysics(),
                                  enlargeCenterPage: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _index = index;
                                      controller.paginateStudents(
                                          (index),
                                          controller.categories.keys.toList()[
                                              controller.categories.keys
                                                  .toList()
                                                  .indexOf(
                                                      widget.categoryName)]);
                                    });
                                  },
                                  scrollDirection: Axis.vertical)),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        width: 60,
                        child: AnimatedSwitcher(
                          child: _index != widget.cat.length - 1
                              ? FloatingActionButton(
                                  backgroundColor: AppColor.accentBlue,
                                  child: RotatedBox(
                                      quarterTurns: 3,
                                      child:
                                          Icon(Icons.navigate_before_outlined)),
                                  mini: true,
                                  onPressed: () {
                                    carouselController.nextPage();
                                  },
                                )
                              : Container(),
                          duration: Duration(milliseconds: 300),
                        ),
                      )),
                ],
              ));
  }
}
