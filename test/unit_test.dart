import 'package:coder_fair/controllers/api_controller.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test fetchStudents function", () async {
    var x = await APIClient.fetchStudents();
    expect(x is List<Student>, true);
  });
  test("Test fetchUser function", () async {
    var x =
        await APIClient.fetchUser(email: "freicherz0@gmail.com", password: "");
    expect(x.toString(), "User(role: 4, coderName: freicherz0)");
  });
  test("Test fetchStudents function", () async {
    var x = await APIClient.fetchStudents();
    x.forEach((student) {
      print(student.listOfProjects);
    });
  });
}
