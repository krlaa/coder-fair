import 'package:coder_fair/controllers/login_screen_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends GetView<LoginScreenController> {
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
            Colors.blue,
            Colors.blue.shade800,
          ],
        )),
        // alignment: Alignment.center,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Image.asset(
                'images/tcs-logo-white.png',
                width: 80.w,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'Tampa 2022',
                  style: TextStyle(
                      fontFamily: 'RobotoSlab',
                      fontSize: 20.sp,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Image.asset(
                  'images/cf-logo.png',
                  height: 6.h,
                  width: 90.w,
                ),
              ),
            ),
            buildForm(context),
          ]),
        ),
      )),
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
                  width: 60.w,
                  child: TextFormField(
                    controller: controller.email,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [
                      AutofillHints.email,
                      AutofillHints.username
                    ],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16.sp,
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
                  width: 60.w,
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
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16.sp,
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
                Container(
                  width: 60.0.w,
                  child: Obx(
                    () => CheckboxListTile(
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
                            fontSize: 15.sp,
                            color: Colors.white,
                          ),
                        ),
                        value: controller.rememberPassword,
                        onChanged: (val) => controller.rememberPassword = val),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: 60.w,
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
                        primary: Colors.lightGreenAccent.shade700,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      child: !controller.isLoading
                          ? Text('Login',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 16.sp,
                                color: Colors.white,
                              ))
                          : CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
                TextButton(
                  child: Text("Forgot Password?",
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 15.sp,
                        color: Colors.white,
                      )),
                  onPressed: () {
                    Get.defaultDialog(
                        radius: 5,
                        titlePadding: EdgeInsets.all(20),
                        contentPadding: EdgeInsets.all(40),
                        title: "Forgot your password?",
                        titleStyle: TextStyle(fontFamily: 'RobotoSlab'),
                        content: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text("Contact theCoderSchool at:",
                                style: TextStyle(fontFamily: 'Raleway')),
                            TextButton(
                                child: Text("(813) 422-5566",
                                    style: TextStyle(fontFamily: 'Raleway')),
                                onPressed: () async {
                                  if (!await launch("8134225566"))
                                    throw 'Could not launch 8134225566';
                                }),
                          ],
                        ));
                  },
                )
              ],
            )),
      ),
    );
  }
}
