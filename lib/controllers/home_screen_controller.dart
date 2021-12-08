import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/models/project_model.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'api_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreenController extends GetxController {
  var client = APIClient();

  var _x = YoutubePlayerController(initialVideoId: "").obs;
  get x => _x.value;
  set x(value) => _x.value = value;

  var _currentStudent = Student().obs;
  get currentStudent => _currentStudent.value;
  set currentStudent(value) => _currentStudent.value = value;

  var _currentIndex = 0.obs;
  get currentIndex => _currentIndex.value;
  set currentIndex(value) => _currentIndex.value = value;

  var _currentCategory = "Apps".obs;
  get currentCategory => _currentCategory.value;
  set currentCategory(value) => _currentCategory.value = value;

  var _categories = {}.obs;
  get categories => _categories.value;
  set categories(value) => _categories.value = value;

  var _listOfControllers = [].obs;
  get listOfControllers => _listOfControllers.value;
  set listOfControllers(value) => _listOfControllers.value = value;

  // to tell if students are still being fetched

  var _loadingStudentNames = true.obs;
  get loadingStudentNames => _loadingStudentNames.value;
  set loadingStudentNames(value) => _loadingStudentNames.value = value;

  // to tell if students are still being fetched
  var _loadingStudentInfo = true.obs;
  get loadingStudentInfo => _loadingStudentInfo.value;
  set loadingStudentInfo(value) => _loadingStudentInfo.value = value;

  // once students are fetched put into a list which will be rendered by HomeScreen page
  var _studentList = <Student>[].obs;
  get studentList => _studentList.value;
  set studentList(value) => _studentList.value = value;

  // fetchStudents function calls APICLient class' fetchStudents() and ensure loading is set to false after completion
  Future<void> fetchStudents() async {
    loadingStudentNames = true;
    categories = await client.fetchStudents();

    listOfControllers =
        categories.values.map((e) => CarouselController()).toList();
    loadingStudentNames = false;
  }

  loadStudent(category, index) async {
    loadingStudentInfo = true;
    if (categories[category][index] is Student) {
      currentStudent = categories[category][index];
    } else {
      var x = await client.loadInfo(categories[category][index]);
      categories[category][index] = x;
      currentStudent = x;
    }
    loadingStudentInfo = false;
  }

  paginateStudents(int index, String category) async {
    loadStudent(category, index);
    if (!(categories[category][index] is Student)) {
      var x = await client.paginateStudents(
          index, categories[category].sublist(index + 1, index + 3));
      // print("This is the value of calling paginate students: $x");
      categories[category].replaceRange(index + 1, index + 3, x);
      // print("These are the categories after replacement: ${categories[category]}");
    }
    currentStudent = categories[category][index];
  }

  @override
  void onInit() async {
    await fetchStudents();
    for (var i = 0; i < categories.keys.toList().length; i++) {
      paginateStudents(
        0,
        categories.keys.toList()[i],
      );
    }

    super.onInit();
  }
}
