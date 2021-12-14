import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:coder_fair/models/student_model.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:coder_fair/screens/stacked_card_carousel.dart';

import 'card_screen.dart';

class HomeScreenPage extends GetView<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Obx(() {
          List keys = controller.categories.keys.toList();
          print(controller.categories.keys.toList());
          if (!controller.loadingStudentNames) {
            return DefaultTabController(
                length: keys.length,
                child: Column(
                  children: [
                    TabBar(
                      onTap: (value) {
                        controller.currentCategory =
                            controller.categories.keys.toList()[value];
                      },
                      tabs: keys.map((x) => genericTab("$x")).toList(),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        width: MediaQuery.of(context).size.width >= 1200
                            ? 40.w
                            : 90.w,
                        child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: keys
                                .asMap()
                                .entries
                                .map((entry) {
                                  print(entry.value);
                                  return ValueBuilder<List?>(
                                      initialValue: controller.categories.values
                                          .toList()[entry.key],
                                      builder: (value, update) {
                                        return Column(
                                          children: [
                                            TextFormField(onChanged: (x) {
                                              print(x);
                                              print(value);
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
                                                      .contains(x);
                                                }).toList());
                                              }
                                            }),
                                            Expanded(
                                              child: carousel(
                                                  entry.key, value!, context),
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
            return Center(child: CircularProgressIndicator());
          }
        }));
  }

  Widget carousel(int index2, cat, context) {
    if (cat.isEmpty) {
      return Center(child: Text("Nothing here"));
    } else
      return StackedCardCarousel(
          pageController: PageController(keepPage: true),
          initialOffset: 20.h,
          spaceBetweenItems: 200,
          onPageChanged: (index) {
            controller.currentIndex = index;

            controller.paginateStudents(
                index, controller.categories.keys.toList()[index2]);
          },
          type: StackedCardCarouselType.cardsStack,
          items: cat
              .asMap()
              .entries
              .map((entry) {
                return Container(
                  width: 300,
                  height: 170,
                  child: InkWell(
                    onTap: () {
                      Get.to(
                          CardScreen(
                            student: controller
                                    .categories[controller.currentCategory]
                                [entry.key],
                          ),
                          transition: Transition.size,
                          curve: Curves.easeInOut,
                          opaque: false);
                    },
                    child: Card(
                      elevation: 15,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(child: Text("${entry.value}")),
                      ),
                    ),
                  ),
                );
              })
              .toList()
              .cast<Widget>());
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
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
