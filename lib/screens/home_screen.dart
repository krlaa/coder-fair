import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:coder_fair/controllers/login_screen_controller.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:coder_fair/screens/login_screen.dart';
import 'package:coder_fair/utils/blend_mask.dart';
import 'package:coder_fair/widgets/carousel.dart';
import 'package:coder_fair/widgets/summer_camp_dialog.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:coder_fair/screens/stacked_card_carousel.dart';
import 'package:coder_fair/constants/app_colors.dart';
import 'dart:html' as html;

import 'card_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeScreenController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // leadingWidth: 160,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 120, // Set this height

        leading: PopupMenuButton(
          child: Icon(Icons.menu),
          color: AppColor.buttonGreen,
          onSelected: (value) {
            if (value == 1) {
              Get.offAll(LoginScreen());
            }
            if (value == 2) {
              Get.dialog(SummerCampDialog());
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 1,
                child: Text("Sign Out"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Summer Camps"),
              ),
            ];
          },
        ),

        title: Image.asset(
          "images/cf-logo.png",
          height: 50,
        ),
      ),
      drawer: Drawer(
        child: ListTile(
          title: Text("Sign Out"),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          BlendMask(
              blendMode: BlendMode.multiply,
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'images/bg-1.jpg',
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              )),
          DefaultTextStyle(
              style: TextStyle(fontFamily: 'Raleway', color: AppColor.h2Blk),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        "Welcome ${controller.loginState.currentUser.full_name.split(' ')[0]}",
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontFamily: 'Raleway', color: AppColor.h2Blk)),
                  ),
                  Obx(() {
                    List keys = controller.categories.keys.toList();
                    if (!controller.loadingStudentNames) {
                      return DefaultTabController(
                          length: keys.length,
                          child: Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TabBar(
                                  labelColor: AppColor.buttonDrkGreen,
                                  unselectedLabelColor: AppColor.h2Blk,
                                  // indicatorSize: TabBarIndicatorSize.label,
                                  indicator: UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                          width: 5.0,
                                          color: AppColor.buttonDrkGreen),
                                      insets: EdgeInsets.symmetric(
                                          horizontal: 16.0)),
                                  onTap: (value) {
                                    controller.currentCategory = controller
                                        .categories.keys
                                        .toList()[value];
                                  },
                                  tabs: keys
                                      .map((x) => genericTab("$x"))
                                      .toList(),
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
                                                      .toList()[entry.key]
                                                      .where((x) => (x
                                                                  .eligible ==
                                                              true ||
                                                          controller
                                                              .loginState
                                                              .currentUser
                                                              .coders
                                                              .contains(
                                                                  x.coderName)))
                                                      .toList(),
                                                  builder: (value, update) {
                                                    return Column(
                                                      children: [
                                                        TextFormField(
                                                            autofillHints: [
                                                              "hi"
                                                            ],
                                                            onChanged: (x) {
                                                              if (x.isEmpty) {
                                                                update(controller
                                                                    .categories
                                                                    .values
                                                                    .toList()[
                                                                        entry
                                                                            .key]
                                                                    .where((x) => (x.eligible ==
                                                                            true ||
                                                                        controller
                                                                            .loginState
                                                                            .currentUser
                                                                            .coders
                                                                            .contains(x.coderName)))
                                                                    .toList());
                                                              } else {
                                                                update(controller
                                                                    .categories
                                                                    .values
                                                                    .toList()[
                                                                        entry
                                                                            .key]!
                                                                    .where(
                                                                        (element) {
                                                                  Student j =
                                                                      element;
                                                                  return j.coderName
                                                                          .toLowerCase()
                                                                          .contains(x
                                                                              .toLowerCase()) ||
                                                                      j.codeCoach
                                                                          .toLowerCase()
                                                                          .contains(
                                                                              x.toLowerCase());
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
                                                                      .categories
                                                                      .keys
                                                                      .toList()[
                                                                  entry.key],
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
                            ),
                          ));
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                              color: AppColor.buttonGreen));
                    }
                  }),
                ],
              )),
        ],
      ),
    );
  }
}

Widget genericTab(String tabTitle) {
  return Tooltip(
    message: tabTitle,
    child: Tab(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              tabTitle,
              style: TextStyle(fontFamily: 'RobotoSlab', fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
