import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/models/project_model.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:get/get.dart';
import 'api_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreenController extends GetxController {
  var client = APIClient();

  var currentStudent = Student().obs;

  var _categories = {}.obs;
  get categories => _categories.value;

  var _listOfControllers = [].obs;
  get listOfControllers => _listOfControllers.value;
  // TODO: Remove this
  var _isExpanded = false.obs;
  changeExpanded(outside) {
    _isExpanded.value = outside;
    print(_isExpanded.value);
  }

  get isExpanded => this._isExpanded.value;

  // to tell if students are still being fetched
  var loadingStudentNames = true.obs;

  // to tell if students are still being fetched
  var loadingStudentInfo = true.obs;
  // once students are fetched put into a list which will be rendered by HomeScreen page
  var studentList = <Student>[].obs;

  // fetchStudents function calls APICLient class' fetchStudents() and ensure loading is set to false after completion
  Future<void> fetchStudents() async {
    loadingStudentNames(true);
    _categories.value = await client.fetchStudents();
    _listOfControllers.value =
        _categories.value.values.map((e) => CarouselController()).toList();
    print(_listOfControllers.value);
    loadingStudentNames(false);
  }

  void loadStudent(String coderName) async {
    print(coderName.camelCase);
    loadingStudentInfo(true);
    currentStudent.value = await client.loadInfo(coderName);
    loadingStudentInfo(false);
  }

  paginateStudents(int index, String category) async {
    if (!categories[category][index] is Project) {
      await client.paginateStudents(index, categories[category]);
    }
  }

  @override
  void onInit() async {
    await fetchStudents();
    super.onInit();
  }
}
