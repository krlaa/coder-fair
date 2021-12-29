import 'package:coder_fair/constants/app_colors.dart';
import 'package:coder_fair/controllers/login_screen_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:coder_fair/utils/blend_mask.dart';

class LoginScreen extends GetResponsiveView<LoginScreenController> {
  @override
  Widget build(BuildContext context) {
    // Size _size = MediaQuery.of(context).size;
    return DefaultTextStyle(
      style: TextStyle(fontFamily: 'Raleway'),
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.lightBlue,
            AppColor.darkBlue,
          ],
        )),

        // alignment: Alignment.center,
        child: Stack(
          children: [
            blendMask(),
            bodySection(context),
          ],
        ),
      )),
    );
  }

  BlendMask blendMask() {
    return BlendMask(
        blendMode: BlendMode.multiply,
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Opacity(
            opacity: 0.2,
            child: Image.asset(
              'images/bg-1.jpg',
              repeat: ImageRepeat.repeat,
            ),
          ),
        ));
  }

  Center bodySection(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(20),
          width: 400,

          // decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     AppColor.lightBlue,
          //     AppColor.darkBlue,
          //   ],
          // )),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              tcsLogo(),
              tampa2022(),
              cfLogo(),
              buildForm(context),
            ]),
          ),
        ),
      ),
    );
  }

  Center tcsLogo() {
    return Center(
      child: Image.asset(
        'images/tcs-logo-white.png',
        width: 80.w,
        height: 20.h,
      ),
    );
  }

  Center cfLogo() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Image.asset(
          'images/cf-logo.png',
          height: 6.h,
          width: 90.w,
        ),
      ),
    );
  }

  Center tampa2022() {
    return Center(
      child: Text(
        'Tampa 2022',
        style: TextStyle(
            fontFamily: 'RobotoSlab',
            fontSize: 30,
            // fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }

  Form buildForm(BuildContext context) {
    return Form(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: AutofillGroup(
        child: Obx(() => Column(
              children: [
                Container(
                  width: 75.w,
                  child: TextFormField(
                    controller: controller.email,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [
                      AutofillHints.email,
                      AutofillHints.username
                    ],
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || !GetUtils.isEmail(value)) {
                        return 'Please enter valid email';
                      }
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Container(
                  width: 75.w,
                  child: TextFormField(
                    onChanged: (val) {
                      if (val.length == 0) {
                        controller.resetPassField();
                      }
                    },
                    controller: controller.password,
                    autofillHints: [
                      AutofillHints.password,
                      AutofillHints.newPassword
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                    },
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      suffixIcon: !controller.loadedFromSS
                          ? IconButton(
                              splashRadius: 20,
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                controller.obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                controller.obscurePassword =
                                    !controller.obscurePassword;
                              },
                            )
                          : null,
                    ),
                    obscureText: controller.obscurePassword,
                  ),
                ),
                rememberPassword(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: 75.w,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (controller.formKey.currentState!.validate()) {
                          TextInput.finishAutofillContext(shouldSave: true);
                          controller.signIn();
                        } else {
                          Get.snackbar(
                            "Error",
                            "Nope",
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.buttonGreen,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      child: !controller.isLoading
                          ? Text('Login',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ))
                          : CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
                forgotPassword()
              ],
            )),
      ),
    );
  }

  TextButton forgotPassword() {
    return TextButton(
      child: Text("Forgot Password?",
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 18,
            color: Colors.white,
          )),
      onPressed: () {
        Get.defaultDialog(
            radius: 5,
            titlePadding: EdgeInsets.all(20),
            contentPadding: EdgeInsets.all(40),
            title: "Forgot your password?",
            titleStyle: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColor.h2Blk,
            ),
            content: Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text("Contact theCoderSchool at: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 18,
                          color: AppColor.h2Blk)),
                  InkWell(
                      child: Text("(813) 422-5566",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 18,
                              color: AppColor.darkBlue)),
                      onTap: () async {
                        if (!await launch("tel: 813-422-5566"))
                          throw 'Could not launch 8134225566';
                      }),
                ],
              ),
            ));
      },
    );
  }

  Container rememberPassword() {
    return Container(
      width: 75.w,
      child: Obx(
        () => CheckboxListTile(
            autofocus: false,
            activeColor: AppColor.buttonGreen,
            dense: true,
            contentPadding: EdgeInsets.only(top: 15),
            tileColor: Colors.white,
            selectedTileColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              'Remember Password?',
              maxLines: 2,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            value: controller.rememberPassword,
            onChanged: (val) => controller.rememberPassword = val),
      ),
    );
  }
}
