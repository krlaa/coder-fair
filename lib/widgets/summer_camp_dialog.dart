import 'package:coder_fair/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SummerCampDialog extends StatelessWidget {
  const SummerCampDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 420,
        height: 395,
        child: Stack(
          children: <Widget>[
            Container(
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Text("2022 Summer Camps",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.white)),
                    ) //
                        ),
                    Image.asset("images/final_metaverse.jpg"),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        child: Text("More info @ tampa.thecoderschool.com",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 14,
                                color: AppColor.lightBlue)),
                        onTap: () async {
                          if (!await launch(
                              "https://www.thecoderschool.com/metro/tampa/"))
                            throw 'Could not launch 8134225566';
                        }),
                    SizedBox(
                      height: 20,
                    ),
                  ],
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
      ),
    );
  }
}
