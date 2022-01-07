import 'package:coder_fair/constants/app_colors.dart';
import 'package:coder_fair/controllers/home_screen_controller.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:coder_fair/utils/app_bar.dart';
import 'package:coder_fair/utils/custom_progress_indicator.dart';
import 'package:coder_fair/utils/generic_tab.dart';
import 'package:coder_fair/widgets/carousel.dart';
import 'package:coder_fair/widgets/mobile_info_overlay.dart';
import 'package:coder_fair/widgets/summer_camp_dialog.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  @override
  _MobileHomeScreenState createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  late HomeScreenController controller;

  ScrollController sc = ScrollController();

  @override
  void initState() {
    super.initState();

    controller = Get.put(HomeScreenController());
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.dialog(SummerCampDialog());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: GlobalAppBar(),
        extendBodyBehindAppBar: true,
        backgroundColor: AppColor.black,
        body: DefaultTextStyle(
            style: TextStyle(fontFamily: 'Raleway', color: AppColor.white),
            child: Container(
              margin: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: kToolbarHeight + 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Hello,\n${controller.loginState.currentUser.full_name.split(' ')[0]} 👋",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  fontFamily: 'Raleway',
                                  color: AppColor.white)),
                      RawMaterialButton(
                          fillColor: AppColor.accentPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onPressed: () {
                            Get.dialog(MobileInfo());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: SizedBox(
                              child: Text("Metaverse Camp Info",
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontFamily: 'Raleway')),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.darkGrey,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
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
                                                  .map((x) => GenericTab(
                                                        title: x,
                                                        fontSize: 14,
                                                      ))
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
                                                                      child: TextFormField(
                                                                          decoration: InputDecoration(
                                                                            hoverColor:
                                                                                AppColor.black,
                                                                            filled:
                                                                                true,
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.grey,
                                                                            ),
                                                                            hintText:
                                                                                "Search \'Coder Name\'",
                                                                          ),
                                                                          style: TextStyle(color: AppColor.white, fontWeight: FontWeight.w400, fontSize: 18),
                                                                          autofillHints: [],
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
                                    return CustomProgress();
                                  }
                                }),
                              ),
                            ),
                          ),
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
