import 'package:coder_fair/controllers/api_controller.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io' as io;

void main() async {
  // Map x = {"3": "CodeBat4", "4": "CodeBat5", "5": "CodeBat6"};
  // print(x.values.toList());
  TestWidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = null;
  await dotenv.load(fileName: ".env");
  var client = APIClient();
  test("Test fetchStudents function", () async {
    var x = await client.fetchStudents();
    // print(x);
    expect(x is Map, true);
  });
  // test("Test loadInfo function", () async {
  //   var x = await client.loadInfo("codeBat1");
  //   print(x);
  // });
  // test("Test Login", () async {
  //   var x = await client.fetchUser(
  //       email: "kevindurantony@gmail.com", password: "alliswell");
  //   print(x);
  //   expect(x.toString() is String, true);
  // });
}
