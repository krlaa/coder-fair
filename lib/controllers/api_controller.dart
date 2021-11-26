import 'dart:convert';

import 'package:coder_fair/constants/general_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:coder_fair/constants/api_constants.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:coder_fair/models/user_model.dart';

class APIClient {
  // Opens a http client
  var client = http.Client();

  // fetchStudents function which fetches students projects from Firebase RTDBMS
  Future<List<Student>> fetchStudents() async {
    return Future.delayed(Duration(seconds: 1), () {
      return Student.fromJson(SAMPLE_STUDENT_DATA);
    });
  }

  // fetchUser function fetches the user details from the Firebase RTDBMS
  Future<User> fetchUser(
      {required String email, required String password}) async {
    LoginState info = await signIn(email, password);
    var response = await client.get(Uri.parse(
        "https://coder-fair-default-rtdb.firebaseio.com/users/${info.username}.json"));
    return User.fromJson(response.body);
  }

  // signIn function which is called by fetchUser, this only passes through the Firebase authentication endpoint
  Future<LoginState> signIn(String email, String password) async {
    // defines body of payload for signing in user
    var body = {
      'email': email,
      'password': password,
      "returnSecureToken": true
    };
    // response from post request
    var response;
    try {
      response = await http.post(
          Uri.parse(
              'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${dotenv.env["API_KEY"]}'),
          body: json.encode(body));
      return LoginState(
          token: json.decode(response.body)['idToken'],
          username: regExp.stringMatch(email).toString());
    } catch (e) {
      print(response.statusCode);
      throw Error;
    }
  }

  // close function to close http client to avoid memory leaks.
  void close() {
    client.close();
  }
}

/// Login State class
/// Defines a structure for the login state of the user which includes the token received from firebase and the username that was initially passed to the payload
class LoginState {
  String token;
  String username;
  LoginState({
    required this.token,
    required this.username,
  });
}
