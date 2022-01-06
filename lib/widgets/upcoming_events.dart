import 'package:coder_fair/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text("Upcoming Events:",
                style: TextStyle(
                    fontFamily: 'Raleway',
                    color: AppColor.white,
                    fontSize: 24)),
            SizedBox(height: 50),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                child: Image.asset('images/final_metaverse.jpg'),
              ),
            ),
            SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}
