import 'package:coder_fair/constants/app_colors.dart';
import 'package:coder_fair/controllers/login_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:coder_fair/utils/blend_mask.dart';

class MobileHomeScreen extends GetView<LoginScreenController> {
  var coderName = "Bob";
  var title = "title";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTextStyle(
      style: TextStyle(fontFamily: 'Raleway', color: h2Blk, fontSize: 16.sp),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width >= 900 ? 40.w : 90.w,
          height: 90.h,
          child: bodySection(context),
        ),
      ),
    ));
  }

  bodySection(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          placeHolder(),
          projTitle(),
          studentName(),
          language(),
          description(),
          // ToDo: a description box should be a certain height. insert scroll view to prevent going beyond text
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print("previous");
                  },
                  child: Text('prev coder'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("next");
                  },
                  child: Text('next coder'),
                ),
              ],
            ),
          )
        ]);
  }

  placeHolder() {
    return Center(
        child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 1,
                    child: FloatingActionButton(
                        // heroTag: student.hashCode + 1,
                        mini: true,
                        onPressed: () {})),
                Flexible(
                  flex: 6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:
                        AspectRatio(aspectRatio: 16 / 9, child: Placeholder()),
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: FloatingActionButton(
                        // heroTag: student.hashCode - 1,
                        mini: true,
                        onPressed: () {
                          // controller.cardListController
                          // .nextPage();
                        })),
              ],
            )));
  }

  projTitle() {
    return Text(
      title,
      style: TextStyle(
          fontFamily: 'RobotoSlab',
          fontWeight: FontWeight.bold,
          fontSize: 24.sp,
          color: h2Blk),
    );
  }

  studentName() {
    return Text(
      'creator: $coderName',
      style: TextStyle(fontSize: 16.sp, color: h2Green),
    );
  }

  language() {
    return Text(
      'language:',
      style: TextStyle(fontSize: 16.sp, color: h2Yellow),
    );
  }

  description() {
    return Text(
      'Description:',
      style:
          TextStyle(fontSize: 16.sp, color: h2Blk, fontWeight: FontWeight.bold),
    );
  }
}
