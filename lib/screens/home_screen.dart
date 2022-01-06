import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/constants/extenstions.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:coder_fair/controllers/login_screen_controller.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:coder_fair/screens/login_screen.dart';
import 'package:coder_fair/utils/blend_mask.dart';
import 'package:coder_fair/widgets/carousel.dart';
import 'package:coder_fair/widgets/summer_camp_dialog.dart';
import 'package:coder_fair/widgets/table.dart';
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

  ScrollController sc = ScrollController();

  @override
  void initState() {
    super.initState();

    controller = Get.put(HomeScreenController());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          // leadingWidth: 160,
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton(
              child: Icon(Icons.menu),
              color: AppColor.mediumGrey,
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
                    child: Text("Sign Out",
                        style: TextStyle(
                            color: AppColor.white, fontFamily: 'Raleway')),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text("Summer Camps",
                        style: TextStyle(
                            color: AppColor.white, fontFamily: 'Raleway')),
                  ),
                ];
              },
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 120, // Set this height
          title: Image.asset(
            "images/cf-logo.png",
            height: 50,
          ),
        ),
        endDrawer: SizedBox(
          width: 90.w,
          child: Drawer(
            child: ListTile(
              title: Text("Sign Out",
                  style:
                      TextStyle(color: AppColor.white, fontFamily: 'Raleway')),
            ),
          ),
        ),

        extendBodyBehindAppBar: true,
        backgroundColor: AppColor.black,
        body: DefaultTextStyle(
            style: TextStyle(fontFamily: 'Raleway', color: AppColor.white),
            child: Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                        "Hello,\n${controller.loginState.currentUser.full_name.split(' ')[0]} 👋",
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontFamily: 'Raleway', color: AppColor.white)),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                          color: AppColor.darkGrey,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30),
                                    Text("Upcoming Events",
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            color: AppColor.white,
                                            fontSize: 24)),
                                    SizedBox(height: 50),
                                    Container(
                                      child: Image.asset(
                                          'images/final_metaverse.jpg'),
                                    ),
                                  ],
                                ),
                              )),
                          Flexible(
                            flex: 1,
                            child: Material(
                              elevation: 10,
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColor.mediumGrey,
                                    borderRadius: BorderRadius.circular(15)),
                                padding: EdgeInsets.all(20),
                                child: Obx(() {
                                  List keys =
                                      controller.categories.keys.toList();
                                  if (!controller.loadingStudentNames) {
                                    return DefaultTabController(
                                        length: keys.length,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TabBar(
                                              labelColor: AppColor.white,
                                              unselectedLabelColor:
                                                  AppColor.white,
                                              // indicatorSize: TabBarIndicatorSize.label,
                                              indicator: BoxDecoration(
                                                color: AppColor.accentBlue,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              onTap: (value) {
                                                controller.currentCategory =
                                                    controller.categories.keys
                                                        .toList()[value];
                                              },
                                              tabs: keys
                                                  .map((x) => genericTab("$x"))
                                                  .toList(),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: Device.width >= 1200
                                                    ? 40.w
                                                    : 90.w,
                                                child: TabBarView(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    children: keys
                                                        .asMap()
                                                        .entries
                                                        .map((entry) {
                                                          return ValueBuilder<
                                                                  List?>(
                                                              initialValue: controller
                                                                  .categories
                                                                  .values
                                                                  .toList()[
                                                                      entry.key]
                                                                  .where((x) => (x
                                                                              .eligible ==
                                                                          true ||
                                                                      controller
                                                                          .loginState
                                                                          .currentUser
                                                                          .coders
                                                                          .contains(x
                                                                              .coderName)))
                                                                  .toList(),
                                                              builder: (value,
                                                                  update) {
                                                                return Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              20,
                                                                          bottom:
                                                                              20),
                                                                      child:
                                                                          TextFormField(
                                                                              style: TextStyle(
                                                                                  color: AppColor
                                                                                      .white,
                                                                                  fontWeight: FontWeight
                                                                                      .w400),
                                                                              autofillHints: [
                                                                                "Search for coder\'s \'Coder Name\'"
                                                                              ],
                                                                              onChanged: (x) {
                                                                                if (x.isEmpty) {
                                                                                  update(controller.categories.values.toList()[entry.key].where((x) => (x.eligible == true || controller.loginState.currentUser.coders.contains(x.coderName))).toList());
                                                                                } else {
                                                                                  update(controller.categories.values.toList()[entry.key]!.where((element) {
                                                                                    Student j = element;
                                                                                    return j.coderName.toLowerCase().contains(x.toLowerCase()) || j.codeCoach.toLowerCase().contains(x.toLowerCase());
                                                                                  }).toList());
                                                                                }
                                                                              }),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Container(
                                                                        // color: Colors.black,
                                                                        width:
                                                                            375,
                                                                        child:
                                                                            CarouselBuilderWithIndicator(
                                                                          categoryName: controller
                                                                              .categories
                                                                              .keys
                                                                              .toList()[entry.key],
                                                                          cat:
                                                                              value!,
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
                                        child: CircularProgressIndicator(
                                            color: AppColor.buttonGreen));
                                  }
                                }),
                              ),
                            ),
                          ),
                          Flexible(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30),
                                    Text("Metaverse Camp Schedule",
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            color: AppColor.white,
                                            fontSize: 24)),
                                    SizedBox(height: 50),
                                    SizedBox(
                                      child: CustomSchedule(sc: sc),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
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
              tabTitle.sanatize(),
              style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
