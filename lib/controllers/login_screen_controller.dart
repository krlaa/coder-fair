import 'package:coder_fair/models/user_model.dart';
import 'package:coder_fair/screens/coach_screen.dart';
import 'package:coder_fair/screens/home_screen.dart';
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
  var _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  // show or hide password
  var _obscurePassword = true.obs;
  get obscurePassword => _obscurePassword.value;
  set obscurePassword(value) => _obscurePassword.value = value;

  var _rememberPassword = false.obs;
  get rememberPassword => _rememberPassword.value;
  set rememberPassword(value) => _rememberPassword.value = value;

  //Defines current user this value will be accessed through this controller to determine vote weight; is obs because will need to observe always
  Rx<User> _currentUser = User(coderName: "", role: 0).obs;

  // Sign in function to sign in the user
  // isLoading is set to true so that the UI responds to processing of data
  // TODO: Create specific snackbar to react to custom errors.
  void signIn() async {
    var box = Hive.box('userPreferences');
    box.put('rememberPassword', _rememberPassword.value);
    _isLoading(true);
    if (_rememberPassword.value) {
      insertSecret();
    }
    try {
      _currentUser.value =
          await client.fetchUser(email: email.text, password: password.text);
    } catch (e) {
      Get.snackbar("Uh oh", "Looks like something went wrong");
      throw Error();
    } finally {
      _isLoading(false);
    }
    if (_currentUser.value.role == 3) {
      Get.to(CoachScreen());
    }
    Get.to(HomeScreen());
  }

  @override
  void onInit() async {
    var box = Hive.box('userPreferences');
    var exists = box.get('rememberPassword');
    _rememberPassword.value = exists;
    if (exists) {
      getSecret();
    }
    super.onInit();
  }

  // Ensure the key is available to write to
  void ensureKey() async {
    var containsEncryptionKey =
        await secureStorage.containsKey(key: 'youshallnotpass');
    if (!containsEncryptionKey) {
      var key = Hive.generateSecureKey();
      await secureStorage.write(
          key: 'youshallnotpass', value: base64UrlEncode(key));
    }
  }

  // inserts the secrets to the encrypted box
  void insertSecret() async {
    ensureKey();
    var encryptionKey = base64Url
        .decode(await secureStorage.read(key: 'youshallnotpass') ?? "");
    var encryptedBox = await Hive.openBox('vaultBox',
        encryptionCipher: HiveAesCipher(encryptionKey));
    encryptedBox.put('email', email.text);
    encryptedBox.put('password', password.text);
  }

  // Gets the secret then sets the text fields to the appropriate information. Disables the password visibility toggle to ensure people cannot obtain password easily
  void getSecret() async {
    ensureKey();
    var encryptionKey = base64Url
        .decode(await secureStorage.read(key: 'youshallnotpass') ?? "");
    var encryptedBox = await Hive.openBox('vaultBox',
        encryptionCipher: HiveAesCipher(encryptionKey));
    email.text = encryptedBox.get('email');
    password.text = encryptedBox.get('password');
    _loadedFromSS.value = true;
  }
}
