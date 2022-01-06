import 'package:coder_fair/constants/extenstions.dart';
import 'package:flutter/material.dart';

class GenericTab extends StatelessWidget {
  const GenericTab({Key? key, required this.title, required this.fontSize})
      : super(key: key);
  final String title;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: title,
      child: Tab(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                title.sanatize(),
                style: TextStyle(fontFamily: 'Raleway', fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
