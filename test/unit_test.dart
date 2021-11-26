import 'package:coder_fair/controllers/api_controller.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io' as io;

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = null;
  await dotenv.load(fileName: ".env");
  var client = APIClient();
  test("Test fetchStudents function", () async {
    var x = await client.fetchStudents();
    expect(x is List<Student>, true);
  });
  test("Test Login", () async {
    var x = await client.fetchUser(
        email: "kevindurantony@gmail.com", password: "alliswell");
    print(x);
    expect(x.toString() is String, true);
  });
}
