import 'package:coder_fair/constants/app_colors.dart';
import 'package:coder_fair/widgets/table.dart';
import 'package:flutter/material.dart';

class MetaverseSchedule extends StatelessWidget {
  const MetaverseSchedule({
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
            Text("Metaverse Camp Schedule:",
                style: TextStyle(
                    fontFamily: 'Raleway',
                    color: AppColor.white,
                    fontSize: 24)),
            SizedBox(height: 50),
            SizedBox(
              child: CustomSchedule(),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
