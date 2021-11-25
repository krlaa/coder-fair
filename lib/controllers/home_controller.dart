import 'package:coder_fair/models/student_model.dart';
import 'package:get/get.dart';
import 'api_controller.dart';

class HomeController extends GetxController {
  final _isExpanded = false.obs;
  changeExpanded(outside) {
    _isExpanded.value = outside;
    print(_isExpanded.value);
  }

  get isExpanded => this._isExpanded.value;

  // to tell if students are still being fetched
  var fetchStudentsLoading = true.obs;
  // once students are fetched put into a list which will be rendered by HomeScreen page
  var studentList = <Student>[].obs;

  // fetchStudents function calls APICLient class' fetchStudents() and ensure loading is set to false after completion
  void fetchStudents() {
    fetchStudentsLoading(true);
    APIClient.fetchStudents();
    fetchStudentsLoading(false);
  }

  @override
  void onInit() {
    fetchStudents();
    super.onInit();
  }
}
