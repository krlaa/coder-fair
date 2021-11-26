import 'package:coder_fair/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: AutofillGroup(
            child: Obx(() => Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: [
                        AutofillHints.email,
                        AutofillHints.username
                      ],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (value) {
                        if (value == null || !GetUtils.isEmail(value)) {
                          return 'Please enter valid email';
                        }
                      },
                    ),
                    TextFormField(
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
                        hintText: "Password",
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
                    Row(
                      children: [
                        Obx(() => Expanded(
                              child: CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text('remember password'),
                                  value: controller.rememberPassword,
                                  onChanged: (val) =>
                                      controller.rememberPassword = val),
                            )),
                        Expanded(
                            child: TextButton(
                          child: Text("Forgot Password?"),
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
                                          if (!await launch("8134225566"))
                                            throw 'Could not launch 8134225566';
                                        }),
                                  ],
                                ));
                          },
                        ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (controller.formKey.currentState!.validate()) {
                            TextInput.finishAutofillContext(shouldSave: true);
                            controller.signIn();
                          } else {
                            Get.snackbar("Error", "nope");
                          }
                        },
                        child: !controller.isLoading
                            ? Text('Submit')
                            : CircularProgressIndicator(
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
