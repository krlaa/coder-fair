import 'dart:convert';

import 'package:coder_fair/constants/general_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:coder_fair/models/project_model.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:coder_fair/models/user_model.dart';

class APIClient {
  // Opens a http client
  var client = http.Client();
  var baseDomain = usingEmulator
      ? "http://localhost:9000/"
      : "https://coder-fair-default-rtdb.firebaseio.com/";
  var query = usingEmulator ? "?ns=coder-fair" : "";
  var authEmulatorDomain = usingEmulator ? "localhost:9099/" : "";
  // fetchStudents function which fetches students projects from Firebase RTDBMS
  Future<Map<String, List<Student>>> fetchStudents() async {
    print(baseDomain);
    var response = await client
        .get(Uri.parse("${baseDomain}project_categories.json${query}"));
    Map<String, dynamic> categories = json.decode(response.body);
    Map<String, List<Student>> result = {};

    for (MapEntry k in categories.entries) {
      List<Student> l = [];
      for (var element in k.value) {
        var response = await client
            .get(Uri.parse("${baseDomain}coder_detail/$element.json${query}"));
        var decoded = json.decode(response.body);
        l.add(Student.fromJson(decoded, "$element"));
      }
      result[k.key] = l;
    }

    return result;
  }

  Future<Student> loadInfo(Student student) async {
    var coderProjects = json.decode((await client.get(
            Uri.parse("${baseDomain}coders/${student.coderName}.json${query}")))
        .body);

    List<Project> j = [];
    for (var element in coderProjects) {
      var x = json.decode((await client.get(
              Uri.parse("${baseDomain}project_detail/${element}.json${query}")))
          .body);

      j.add(Project.fromMap(x, "$element", student.coderName));
    }

    return student.copyWith(listOfProjects: j, loadFull: true);
  }

  // fetchUser function fetches the user details from the Firebase RTDBMS
  Future<User> fetchUser(
      {required String email, required String password}) async {
    UserPayload info = await signIn(email, password);
    var response = await client
        .get(Uri.parse("${baseDomain}user/${info.uid}.json${query}"));
    return User.fromJson(response.body, info);
  }

  // signIn function which is called by fetchUser, this only passes through the Firebase authentication endpoint
  Future<UserPayload> signIn(String email, String password) async {
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
              'http://${authEmulatorDomain}identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${dotenv.env["API_KEY"]}'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body));
      return UserPayload.fromJson(response.body);
    } catch (e) {
      throw Error;
    }
  }

  // close function to close http client to avoid memory leaks.
  void close() {
    client.close();
  }

  //
  void increaseLikeCount() {}
}

/// User Payload class
/// Defines a structure for the login state of the user which includes the token received from firebase and the username that was initially passed to the payload
class UserPayload {
  String token;
  String uid;
  String refreshToken;
  String email;
  int expiresIn;
  UserPayload({
    required this.token,
    required this.uid,
    required this.refreshToken,
    required this.email,
    required this.expiresIn,
  });
  UserPayload.none(
      {this.token = "",
      this.uid = "",
      this.refreshToken = "",
      this.email = "",
      this.expiresIn = 0});
  UserPayload copyWith({
    String? token,
    String? uid,
    String? refreshToken,
    String? email,
    int? expiresIn,
  }) {
    return UserPayload(
      token: token ?? this.token,
      uid: uid ?? this.uid,
      refreshToken: refreshToken ?? this.refreshToken,
      email: email ?? this.email,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }

  factory UserPayload.fromMap(Map<String, dynamic> map) {
    return UserPayload(
      token: map['idToken'] ?? '',
      uid: map['localId'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      email: map['email'] ?? '',
      expiresIn: int.tryParse(map['expiresIn']) ?? 0,
    );
  }

  factory UserPayload.fromJson(String source) =>
      UserPayload.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserPayload(token: $token, uid: $uid, refreshToken: $refreshToken, email: $email, expiresIn: $expiresIn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserPayload &&
        other.token == token &&
        other.uid == uid &&
        other.refreshToken == refreshToken &&
        other.email == email &&
        other.expiresIn == expiresIn;
  }
}
