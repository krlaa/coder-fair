import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => controller.changeExpanded(true),
          ),
          body: SafeArea(
            child: DefaultTextStyle(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.sp),
              child: Row(
                children: [
                  Flexible(
                      flex: 4,
                      child: Column(
                        children: [
                          Obx(() => CarouselSlider.builder(
                              itemCount: 4,
                              itemBuilder: (BuildContext c, int v, int x) =>
                                  FractionallySizedBox(
                                    heightFactor: 2.25.sp,
                                    widthFactor: 2.25.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(15),
                                        elevation: 8,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(child: Text("$v")),
                                        ),
                                      ),
                                    ),
                                  ),
                              options: CarouselOptions(
                                viewportFraction: 0.3,
                                scrollDirection: Axis.horizontal,
                                height: 200,
                                initialPage: 0,
                                enlargeCenterPage: controller.isExpanded,
                              ))),
                          CarouselSlider.builder(
                              itemCount: 4,
                              itemBuilder: (BuildContext c, int v, int x) =>
                                  FractionallySizedBox(
                                    heightFactor: 0.8,
                                    widthFactor: 0.9,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(15),
                                        elevation: 8,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(child: Text("$v")),
                                        ),
                                      ),
                                    ),
                                  ),
                              options: CarouselOptions(
                                viewportFraction: 0.3,
                                scrollDirection: Axis.horizontal,
                                height: 200,
                                initialPage: 0,
                                enlargeCenterPage: true,
                              )),
                          CarouselSlider.builder(
                              itemCount: 4,
                              itemBuilder: (BuildContext c, int v, int x) =>
                                  FractionallySizedBox(
                                    heightFactor: 0.8,
                                    widthFactor: 0.9,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(15),
                                        elevation: 8,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(child: Text("$v")),
                                        ),
                                      ),
                                    ),
                                  ),
                              options: CarouselOptions(
                                viewportFraction: 0.3,
                                scrollDirection: Axis.horizontal,
                                height: 200,
                                initialPage: 0,
                                enlargeCenterPage: true,
                              ))
                        ],
                      )),
                  if (constraints.maxWidth > 1250)
                    Flexible(
                        flex: 3,
                        child: Container(
                          color: Colors.green,
                        ))
                ],
              ),
            ),
          ));
    });
  }
}
