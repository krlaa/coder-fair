import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/models/project_model.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:coder_fair/screens/card_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'api_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreenController extends GetxController {
  var client = APIClient();

  var _cardListController = CarouselController().obs;
  get cardListController => _cardListController.value;
  set cardListController(value) => _cardListController.value = value;
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
  }

  loadStudent(category, index) async {
    loadingStudentInfo = true;
    if (!(categories[category][index].codeCoach.isEmpty)) {
      print("now im here");
      currentStudent = categories[category][index];
    } else {
      var x = await client.loadInfo(categories[category][index].coderName);
      categories[category][index] = x;
      currentStudent = x;
    }
    loadingStudentInfo = false;
  }

  loadAndReturn(category, element) async {
    if (!(element.codeCoach.isEmpty)) {
      print("now im here");
      return element;
    } else {
      var x = await client.loadInfo(element.coderName);
      return x;
    }
  }

  paginateStudents(int index, String category) async {
    if (categories[category].length > 1 ||
        categories[category].length - 1 != index) {
      if ((categories[category][index + 1].codeCoach.isEmpty)) {
        var subI = sublistIndex(index, category);
        List<Student> result = [];
        await Future.forEach(categories[category].sublist(index + 1, subI),
            (Student element) async {
          var x = await loadAndReturn(category, element);
          result.add(x);
        });
        // var x = await client.paginateStudents(
        //     index, categories[category].sublist(index + 1, subI));
        // print("This is the value of calling paginate students: $x");

        categories[category].replaceRange(index + 1, subI, result);
        // print(
        // "These are the categories after replacement: ${categories[category]}");
      }
      await loadStudent(category, index);

      currentStudent = categories[category][index];
    } else {
      await loadStudent(category, index);

      currentStudent = categories[category][index];
    }
  }

  @override
  void onInit() async {
    await fetchStudents();

    await Future.forEach(categories.keys.toList(), (String x) async {
      await paginateStudents(0, x);
    });
    loadingStudentNames = false;

    super.onInit();
  }

  void sendToCardScreen(index) {
    Get.to(
        CardScreen(
          student: categories[currentCategory][index],
        ),
        opaque: false);
  }

  //returns the index based on the category list length
  int sublistIndex(index, category) {
    return (index + 4 > categories[category].length ||
            index == categories[category].length - 1)
        ? index + (categories[category].length - index)
        : index + 4;
  }
}
