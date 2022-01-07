import 'dart:io' as io;

import 'package:coder_fair/controllers/api_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  // Map x = {"3": "CodeBat4", "4": "CodeBat5", "5": "CodeBat6"};
  //
  TestWidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = null;

  var client = APIClient();
  test("Test fetchStudents function", () async {
    var x = await client.fetchStudents();
    //
    expect(x is Map, true);
  });
  // test("Test loadInfo function", () async {
  //   var x = await client.loadInfo("codeBat1");
  //
  // });
  // test("Test Login", () async {
  //   var x = await client.fetchUser(
  //       email: "kevindurantony@gmail.com", password: "alliswell");
  //
  //   expect(x.toString() is String, true);
  // });
}
