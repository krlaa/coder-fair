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
  @override
  void initState() {
    super.initState();
    controller = Get.find();
  }

  int _index = 0;
  bool get wantKeepAlive => true;
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
                        child: Icon(Icons.arrow_downward_sharp),
                        mini: true,
                        onPressed: () {
                          carouselController.nextPage();
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
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      constraints: BoxConstraints.loose(Size(
                                          Device.width >= 1200 ? 40.w : 90.w,
                                          85.h)),
                                      context: context,
                                      builder: (context) {
                                        return Wrap(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                height: 90.h,
                                                child: CardScreen(
                                                  student: entry.value,
                                                  categoryName:
                                                      widget.categoryName,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                              },
                              child: Stack(
                                children: [
                                  Card(
                                    elevation: 15,
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      decoration: BoxDecoration(
                                        color: entry.key == _index
                                            ? Colors.white
                                            : Colors.yellow,
                                      ),
                                      child:
                                          Center(child: Text("${entry.value}")),
                                    ),
                                  ),
                                  AnimatedSwitcher(
                                    duration: Duration(seconds: 5),
                                    child: entry.key == _index
                                        ? ClipRRect(
                                            child: BackdropFilter(
                                              child: Container(),
                                              filter: ImageFilter.blur(
                                                  sigmaX: 0, sigmaY: 0),
                                            ),
                                          )
                                        : ClipRRect(
                                            child: BackdropFilter(
                                              child: Container(),
                                              filter: ImageFilter.blur(
                                                  sigmaX: 4, sigmaY: 4),
                                            ),
                                          ),
                                    switchInCurve: Curves.easeInOut,
                                    switchOutCurve: Curves.easeInOut,
                                  )
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
                        child: Icon(Icons.arrow_upward_sharp),
                        mini: true,
                        onPressed: () {
                          carouselController.previousPage();
                        },
                      )),
                ],
              ));
  }
}
