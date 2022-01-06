import 'package:coder_fair/constants/app_colors.dart';
import 'package:coder_fair/widgets/upcoming_events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'metaverse_schedule.dart';

class MobileInfo extends StatelessWidget {
  const MobileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            width: 100.w,
            margin: EdgeInsets.only(top: 13, left: 8),
            decoration: BoxDecoration(
                color: AppColor.metaBlue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Theme(
              data: ThemeData(
                  scrollbarTheme: ScrollbarThemeData(
                isAlwaysShown: true,
                thumbColor: MaterialStateProperty.all(AppColor.accentBlue),
                trackBorderColor: MaterialStateProperty.all(Colors.white),
                trackColor: MaterialStateProperty.all(AppColor.lightGrey),
              )),
              child: Container(
                child: Scrollbar(
                  showTrackOnHover: true,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        MetaverseSchedule(),
                        UpcomingEvents(),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: AppColor.buttonGreen),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
