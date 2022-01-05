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
      child: Container(
        width: 30.w,
        height: 55.h,
        color: Colors.transparent,
        margin: EdgeInsets.only(left: 0.0, right: 0.0),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text("2022 Summer Camps",
                        style: TextStyle(fontSize: 30.0, color: Colors.white)),
                  ) //
                      ),
                  Image.network(
                      "https://s3-alpha-sig.figma.com/img/fd39/ad2a/52ba8fc689c10d3cd73d95be8677e5b9?Expires=1641772800&Signature=OP8SxMY~DoPleqmoNx1ZqQiClkd23tM4HHASekdZcOEgl2736C9a~NSZrrbLicxSO0sR0xJanM3vybhObNqxGtp0b-IG31edHAb1FQT6DHdjlm6cWdlLsaqqzRnaHWBDv98TR07nH8afW4kfyLSgFIPT85WRF977piMuuz4Lqeu-RAKNaQE9od09YTBx-3L5qnPhiiZbUC8TqqNN066--HB3MVMlHHMQUuSdOAfr2~Dk9Jnn5VTFKnYenZsV7MVFKe1jYWmTuonUG~bL8-NPunyP6r0IfZbRrPk1yfZ~vfURg6uD2NZwihrbwY93YH5hcHUAZfMlIB~Am~7UWr1IMw__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA"),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      child: Text(
                          "More info @ New Tampa | South Tampa | Carrollwood",
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 14,
                              color: AppColor.lightBlue)),
                      onTap: () async {
                        if (!await launch("8134225566"))
                          throw 'Could not launch 8134225566';
                      }),
                  SizedBox(
                    height: 20,
                  ),
                ],
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
