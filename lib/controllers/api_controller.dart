import 'package:coder_fair/constants/api_constants.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:coder_fair/models/user_model.dart';

class APIClient {
  static Future<List<Student>> fetchStudents() async {
    // TODO: link to Firebase API
    return Future.delayed(Duration(seconds: 1), () {
      return Student.fromJson(SAMPLE_STUDENT_DATA);
    });
  }

  static Future<User> fetchUser(
      {required String email, required String password}) {
    // TODO: link to Firebase API
    // TODO: Add login function then pass auth to Firebase REST
    return Future.delayed(Duration(seconds: 1), () {
      return User.fromJson(SAMPLE_USER_DATA);
    });
  }
}
