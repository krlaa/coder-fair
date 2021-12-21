import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/constants/extenstions.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:coder_fair/screens/stacked_card_carousel.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CardScreen extends StatefulWidget {
  Student student;
  String categoryName;
  CardScreen({required this.student, required this.categoryName})
      : _caroController = CarouselController();

  var _caroController;

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
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
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Center(
          child: Container(
              // width: Device.width >= 900 ? 35.w : 90.w,
              height: 90.h,
              color: Colors.green,
              child: widget.student.loadFull
                  ? Column(
                      children: [
                        Text("${widget.student}"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                flex: 1,
                                child: (widget.student.listOfProjects.length >
                                        1)
                                    ? FloatingActionButton(
                                        heroTag: widget.student.hashCode + 1,
                                        mini: true,
                                        onPressed: () {
                                          widget._caroController.previousPage();
                                        })
                                    : Spacer()),
                            Flexible(
                              flex: 6,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: CarouselSlider.builder(
                                    options:
                                        CarouselOptions(viewportFraction: 1),
                                    carouselController: widget._caroController,
                                    itemCount:
                                        widget.student.listOfProjects.length,
                                    itemBuilder: (context, index, realIndex) {
                                      var ytb_controller =
                                          YoutubePlayerController(
                                              initialVideoId: widget
                                                  .student
                                                  .listOfProjects[index]
                                                  .videoURL
                                                  .getVideoId());
                                      return YoutubePlayerIFrame(
                                        aspectRatio: 16 / 9,
                                        controller: ytb_controller,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                                flex: 1,
                                child: (widget.student.listOfProjects.length >
                                        1)
                                    ? FloatingActionButton(
                                        heroTag: widget.student.hashCode - 1,
                                        mini: true,
                                        onPressed: () {
                                          widget._caroController.nextPage();
                                        })
                                    : Spacer()),
                          ],
                        )
                      ],
                    )
                  : Center(child: CircularProgressIndicator())),
        ));
  }
}
