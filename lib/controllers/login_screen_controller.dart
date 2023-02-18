// ignore_for_file: unused_import

import 'dart:typed_data';

import 'package:coder_fair/models/role_model.dart';
import 'package:coder_fair/models/user_model.dart';
import 'package:coder_fair/screens/home_screen.dart';
import 'package:coder_fair/utils/layout_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_controller.dart';
import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class LoginScreenController extends GetxController {
  // Client to call api resources
  var client = APIClient();

  // opens secure storage
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // loaded from secure storage
  var _loadedFromSS = false.obs;
  get loadedFromSS => _loadedFromSS.value;

  // Indicate processing data
  var _isLoading = false.obs;
  get isLoading => _isLoading.value;

  // Text controllers for email and password fields
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // Form

  // show or hide password
  var _obscurePassword = true.obs;
  get obscurePassword => _obscurePassword.value;
  set obscurePassword(value) => _obscurePassword.value = value;

  var _rememberPassword = false.obs;
  get rememberPassword => _rememberPassword.value;
  set rememberPassword(value) => _rememberPassword.value = value;

  //Defines current user this value will be accessed through this controller to determine vote weight; is obs because will need to observe always

  var _currentUser =
      User(role: Role.none(), coders: [], token: UserPayload.none()).obs;
  get currentUser => _currentUser.value;
  set currentUser(value) => _currentUser.value = value;

  // Ensures if the user deletes the whole password after loadedFromSS then password field will reset to include visibility icon.
  void resetPassField() {
    _loadedFromSS.value = false;
  }

  void resetPasswords(email) async {
    print(email);
    client.resetPassword(email);
  }

  // Sign in function to sign in the user
  // isLoading is set to true so that the UI responds to processing of data
  // TODO: Create specific snackbar to react to custom errors.
  void signIn() async {
    var box = Hive.box('userPreferences');
    box.put('rememberPassword', _rememberPassword.value);
    _isLoading(true);
    if (_rememberPassword.value) {
      await insertSecret();
    }
    try {
      print(password.text);
      currentUser =
          await client.fetchUser(email: email.text, password: password.text);
    } catch (e) {
      Get.snackbar("Uh oh", "Looks like something went wrong");
      print(e.toString());
      throw Error();
    } finally {
      _isLoading(false);
      if (currentUser.role.name != "invalid")
        await Get.offAll(AdaptiveHomeScreen());
    }
  }

  reset() {
    currentUser =
        User(role: Role.none(), coders: [], token: UserPayload.none());
  }

  @override
  void onInit() async {
    super.onInit();
    var box = Hive.box('userPreferences');
    var exists = box.get('rememberPassword');
    _rememberPassword.value = exists;
    if (exists) {
      await getSecret();
    }
  }

  // inserts the secrets to the encrypted box
  Future<void> insertSecret() async {
    var encryptedBox = await Hive.openBox('vaultBox');
    encryptedBox.put('email', email.text);
    encryptedBox.put('password', password.text);
  }

  // Gets the secret then sets the text fields to the appropriate information. Disables the password visibility toggle to ensure people cannot obtain password easily
  Future<void> getSecret() async {
    var encryptedBox = await Hive.openBox('vaultBox');
    email.text = encryptedBox.get('email');
    password.text = encryptedBox.get('password');
    _loadedFromSS.value = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
