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
                                  return ValueBuilder<List?>(
                                      initialValue: controller.categories.values
                                          .toList()[entry.key],
                                      builder: (value, update) {
                                        return Column(
                                          children: [
                                            TextFormField(
                                                autocorrect: true,
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
                                                              .contains(x) ||
                                                          j.codeCoach
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
    return AnimatedSwitcher(
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        child: cat.isEmpty
            ? Center(
                child: Text("Nothing here"),
              )
            : StackedCardCarousel(
                pageController:
                    PageController(initialPage: cat.length, keepPage: true),
                initialOffset: 20.h,
                spaceBetweenItems: 350,
                onPageChanged: (index) {
                  controller.currentIndex = index;

                  controller.paginateStudents((cat.length - 1 - index),
                      controller.categories.keys.toList()[index2]);
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
                            if (controller.currentIndex ==
                                cat.length - 1 - entry.key)
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  constraints: BoxConstraints.loose(Size(
                                      MediaQuery.of(context).size.width >= 1200
                                          ? 40.w
                                          : 90.w,
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
                                              student: controller.categories[
                                                      controller
                                                          .currentCategory]
                                                  [entry.key],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            // Get.bottomSheet(
                            //     CardScreen(
                            //       student: controller.categories[
                            //           controller.currentCategory][entry.key],
                            //     ),
                            //     backgroundColor: Colors.red,
                            //     persistent: true);
                            // Get.to(
                            //     CardScreen(
                            //       student: controller.categories[
                            //           controller.currentCategory][entry.key],
                            //     ),
                            //     transition: Transition.size,
                            //     curve: Curves.easeInOut,
                            //     opaque: false);
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
                    .reversed
                    .toList()
                    .cast<Widget>()));
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
