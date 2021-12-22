import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:coder_fair/screens/card_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  int _index = 0;
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    controller = Get.find();
  }

  @override
  void didUpdateWidget(covariant CarouselBuilderWithIndicator oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _index = 0;
    update();
    setState(() {});
  }

  void update() async {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 1,
                      child: FloatingActionButton(
                        child: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(Icons.navigate_before_outlined)),
                        mini: true,
                        onPressed: () {
                          carouselController.previousPage();
                        },
                      )),
                  Flexible(
                    flex: 5,
                    child: CarouselSlider.builder(
                        carouselController: carouselController,
                        itemCount: widget.cat.asMap().entries.toList().length,
                        itemBuilder: (context, index, realIndex) {
                          var entry =
                              widget.cat.asMap().entries.toList()[index];
                          return Container(
                            width: 300,
                            height: 170,
                            child: InkWell(
                              onTap: () {
                                if (_index == entry.key)
                                  Get.dialog(ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height: 90.h,
                                        child: CardScreen(
                                          student: entry.value,
                                          categoryName: widget.categoryName,
                                        ),
                                      )));
                              },
                              child: Stack(
                                children: [
                                  Card(
                                    elevation: 15,
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      decoration: BoxDecoration(),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                                entry.value.profilePictureURL),
                                          ),
                                          Text(entry.value.coderName)
                                        ],
                                      )),
                                    ),
                                  ),
                                  ClipRRect(
                                    child: BackdropFilter(
                                      child: Container(),
                                      filter: ImageFilter.blur(
                                          sigmaX:
                                              entry.key == _index ? 0.001 : 4,
                                          sigmaY:
                                              entry.key == _index ? 0.001 : 4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                            enableInfiniteScroll: false,
                            viewportFraction: 0.3,
                            enlargeCenterPage: true,
                            height: 50.h,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _index = index;
                                controller.paginateStudents(
                                    (index),
                                    controller.categories.keys.toList()[
                                        controller.categories.keys
                                            .toList()
                                            .indexOf(widget.categoryName)]);
                              });
                            },
                            scrollDirection: Axis.vertical)),
                  ),
                  Flexible(
                      flex: 1,
                      child: FloatingActionButton(
                        child: RotatedBox(
                            quarterTurns: 3,
                            child: Icon(Icons.navigate_before_outlined)),
                        mini: true,
                        onPressed: () {
                          carouselController.nextPage();
                        },
                      )),
                ],
              ));
  }
}
