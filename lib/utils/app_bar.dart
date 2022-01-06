import 'package:coder_fair/constants/app_colors.dart';
import 'package:coder_fair/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlobalAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leadingWidth: 160,
      centerTitle: false,
      automaticallyImplyLeading: false,
      actions: [
        PopupMenuButton(
          child: Icon(Icons.menu),
          color: AppColor.mediumGrey,
          onSelected: (value) {
            if (value == 1) {
              Get.offAll(LoginScreen());
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 1,
                child: Text("Sign Out",
                    style: TextStyle(
                        color: AppColor.white, fontFamily: 'Raleway')),
              ),
            ];
          },
        ),
        SizedBox(width: 25)
      ],
      elevation: 0,
      backgroundColor: Colors.transparent,
      // toolbarHeight: 120, // Set this height
      title: Image.asset(
        "images/cf-logo.png",
        height: 50,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
