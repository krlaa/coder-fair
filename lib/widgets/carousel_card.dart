import 'dart:ui';

import 'package:flutter/material.dart';

class CarouselCard extends StatefulWidget {
  MapEntry entry;
  int index;
  CarouselCard({Key? key, required this.entry, required this.index})
      : super(key: key);

  @override
  _CarouselCardState createState() => _CarouselCardState();
}

class _CarouselCardState extends State<CarouselCard> {
  @override
  void didUpdateWidget(covariant CarouselCard oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 15,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      NetworkImage(widget.entry.value.profilePictureURL),
                ),
                Text(widget.entry.value.coderName)
              ],
            )),
          ),
        ),
        AnimatedSwitcher(
          duration: Duration(seconds: 5),
          child: widget.entry.key == widget.index
              ? ClipRRect(
                  child: BackdropFilter(
                    child: Container(),
                    filter: ImageFilter.blur(sigmaX: 0.001, sigmaY: 0.001),
                  ),
                )
              : ClipRRect(
                  child: BackdropFilter(
                    child: Container(),
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  ),
                ),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
        )
      ],
    );
  }
}
