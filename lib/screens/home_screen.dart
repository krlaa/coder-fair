import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:coder_fair/widgets/carousel.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:coder_fair/screens/stacked_card_carousel.dart';
import 'package:coder_fair/constants/app_colors.dart';

import 'card_screen.dart';

class HomeScreen extends GetView<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontFamily: 'Raleway', color: AppColor.h2Blk),
      child: Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
          body: Obx(() {
            List keys = controller.categories.keys.toList();
            if (!controller.loadingStudentNames) {
              return DefaultTabController(
                  length: keys.length,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Color(0xFFFFFFFF),
                        unselectedLabelColor: AppColor.h2Blk,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            AppColor.buttonGreen,
                            AppColor.buttonDrkGreen,
                          ]),
                        ),
                        onTap: (value) {
                          controller.currentCategory =
                              controller.categories.keys.toList()[value];
                        },
                        tabs: keys.map((x) => genericTab("$x")).toList(),
                      ),
                      Expanded(
                        child: Container(
                          width: Device.width >= 1200 ? 40.w : 90.w,
                          child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: keys
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                    return ValueBuilder<List?>(
                                        initialValue: controller
                                            .categories.values
                                            .toList()[entry.key],
                                        builder: (value, update) {
                                          return Column(
                                            children: [
                                              TextFormField(
                                                  decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color: AppColor
                                                              .lightBlue),
                                                      hintText: "Search"),
                                                  autofillHints: ["hi"],
                                                  onChanged: (x) {
                                                    if (x.isEmpty) {
                                                      update(controller
                                                          .categories.values
                                                          .toList()[entry.key]);
                                                    } else {
                                                      update(controller
                                                          .categories.values
                                                          .toList()[entry.key]!
                                                          .where((element) {
                                                        Student j = element;
                                                        return j.coderName
                                                                .toLowerCase()
                                                                .contains(x
                                                                    .toLowerCase()) ||
                                                            j.codeCoach
                                                                .toLowerCase()
                                                                .contains(x
                                                                    .toLowerCase());
                                                      }).toList());
                                                    }
                                                  }),
                                              Expanded(
                                                child: Container(
                                                  // color: Colors.black,
                                                  width: 375,
                                                  child:
                                                      CarouselBuilderWithIndicator(
                                                    categoryName: controller
                                                        .categories.keys
                                                        .toList()[entry.key],
                                                    cat: value!,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  })
                                  .toList()
                                  .cast<Widget>()),
                        ),
                      )
                    ],
                  ));
            } else {
              return Center(
                  child: CircularProgressIndicator(color: Colors.white));
            }
          })),
    );
  }
}

Widget genericTab(String tabTitle) {
  return Tooltip(
    message: tabTitle,
    child: Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          tabTitle,
          style: TextStyle(fontFamily: 'RobotoSlab'),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
