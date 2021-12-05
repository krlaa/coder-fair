import 'package:coder_fair/controllers/login_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends GetView<LoginScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntrinsicHeight(
        child: Row(children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.yellow,
                    Colors.lightGreenAccent.shade700,
                  ],
                )),
                height: 1080,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(40),
                          child: Image.asset('images/cf-logo.png',
                              height: 73, width: 276),
                        ),
                      ],
                    ),
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'images/3-in-1.png',
                            height: 561,
                            width: 522,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: (Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  Colors.blue.shade800,
                ],
              )),
              height: 1080,
              alignment: Alignment.center,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Image.asset(
                    'images/tcs-logo-white.png',
                    // height: 561,
                    // width: 522,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 50,
                    ),
                    children: [
                      TextSpan(
                        text: 'Tampa 2022',
                        style: TextStyle(
                            fontFamily: 'RobotoSlab',
                            fontSize: 28,
                            color: Colors.white),
                      ),
                      WidgetSpan(
                        child: Image.asset(
                          'images/cf-logo.png',
                          height: 54,
                          width: 230,
                        ),
                      ),
                    ],
                  ),
                ),
                // Text(
                //   'Tampa 2022',
                //   style: TextStyle(
                //       fontFamily: 'RobotoSlab',
                //       fontSize: 30,
                //       // fontWeight: FontWeight.bold,
                //       color: Colors.white),
                // ),
                // Image.asset(
                //   'images/cf-logo.png',
                //   height: 54,
                //   width: 230,
                // ),
                Form(
                  key: controller.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: AutofillGroup(
                    child: Obx(() => Column(
                          children: [
                            Container(
                              width: 500.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        !GetUtils.isEmail(value)) {
                                      return 'Please enter valid email';
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: 500.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                      fontSize: 15,
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
                                              color: Theme.of(context)
                                                  .primaryColorDark,
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
                            ),
                            SizedBox(
                              width: 530,
                              child: Row(
                                children: [
                                  Obx(() => Expanded(
                                        child: CheckboxListTile(
                                            tileColor: Colors.white,
                                            selectedTileColor: Colors.white,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              'Remember Password?',
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                            value: controller.rememberPassword,
                                            onChanged: (val) => controller
                                                .rememberPassword = val),
                                      )),
                                  Expanded(
                                      child: TextButton(
                                    child: Text("Forgot Password?",
                                        style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 15,
                                          color: Colors.white,
                                        )),
                                    onPressed: () {
                                      Get.defaultDialog(
                                          radius: 5,
                                          titlePadding: EdgeInsets.all(20),
                                          contentPadding: EdgeInsets.all(40),
                                          title: "Forgot your password?",
                                          content: Row(
                                            children: [
                                              Text("Contact theCoderSchool at"),
                                              TextButton(
                                                  child: Text("(813) 422-5566"),
                                                  onPressed: () async {
                                                    if (!await launch(
                                                        "8134225566"))
                                                      throw 'Could not launch 8134225566';
                                                  }),
                                            ],
                                          ));
                                    },
                                  ))
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: SizedBox(
                                width: 483,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      TextInput.finishAutofillContext(
                                          shouldSave: true);
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 20),
                                  ),
                                  child: !controller.isLoading
                                      ? Text('Login',
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontSize: 15,
                                            color: Colors.white,
                                          ))
                                      : CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ]),
            )),
          ),
        ]),
      ),
    );
  }
}
