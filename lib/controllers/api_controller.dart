import 'dart:convert';

import 'package:coder_fair/constants/general_constants.dart';
import 'package:coder_fair/models/project_model.dart';
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
  Future<Map<String, List<Student>>> fetchStudents() async {
    var response = await client.get(Uri.parse(
        "https://coder-fair-default-rtdb.firebaseio.com/project_categories.json"));
    Map<String, dynamic> categories = json.decode(response.body);
    Map<String, List<Student>> result = {};

    for (MapEntry k in categories.entries) {
      List<Student> l = [];
      for (var element in k.value) {
        var response = await client.get(Uri.parse(
            "https://coder-fair-default-rtdb.firebaseio.com/coder_detail/$element.json"));
        var decoded = json.decode(response.body);
        l.add(Student.fromJson(decoded, "$element"));
      }
      result[k.key] = l;

      print(result);
    }

    return result;
  }

  Future<Student> loadInfo(Student student) async {
    var baseUrl = "https://coder-fair-default-rtdb.firebaseio.com/";

    var coderProjects = json.decode((await client
            .get(Uri.parse("${baseUrl}coders/${student.coderName}.json")))
        .body);

    List<Project> j = [];
    for (var element in coderProjects) {
      var x = json.decode((await client
              .get(Uri.parse("${baseUrl}project_detail/${element}.json")))
          .body);

      j.add(Project.fromMap(x, "$element", student.coderName));
    }

    return student.copyWith(listOfProjects: j, loadFull: true);
  }

  // fetchUser function fetches the user details from the Firebase RTDBMS
  Future<User> fetchUser(
      {required String email, required String password}) async {
    LoginState info = await signIn(email, password);
    var response = await client.get(Uri.parse(
        "https://coder-fair-default-rtdb.firebaseio.com/user/${info.username}.json"));
    return User.fromJson(response.body);
  }

  // signIn function which is called by fetchUser, this only passes through the Firebase authentication endpoint
  Future<LoginState> signIn(String email, String password) async {
    // defines body of payload for signing in user
    final body = {
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
      throw Error;
    }
  }

  // close function to close http client to avoid memory leaks.
  void close() {
    client.close();
  }

  Future<List<Student>> paginateStudents(
      int startIndex, List<Student> sublist) async {
    print(sublist);
    List<Student> result = [];
    await Future.forEach(sublist, (Student element) async {
      var x = await loadInfo(element);
      result.add(x);
    });
    return result;
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
