// ignore_for_file: unused_import, duplicate_import

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_fair/controllers/login_screen_controller.dart';
import 'package:coder_fair/models/category_model.dart';
import 'package:coder_fair/models/project_model.dart';
import 'package:coder_fair/models/student_model.dart';
import 'package:coder_fair/screens/card_screen.dart';
import 'package:coder_fair/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'api_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreenController extends GetxController {
  var client = APIClient();

  LoginScreenController _loginState = Get.find();

  var _cardListController = CarouselController().obs;
  get cardListController => _cardListController.value;
  set cardListController(value) => _cardListController.value = value;

  var _currentIndex = 0.obs;
  get currentIndex => _currentIndex.value;
  set currentIndex(value) => _currentIndex.value = value;

  var _currentCategory = "Game_Engine".obs;
  get currentCategory => _currentCategory.value;
  set currentCategory(value) => _currentCategory.value = value;

  var _categories = {}.obs;
  get categories => _categories.value;
  set categories(value) => _categories.value = value;

  var _categories1 = CategoryList().obs;
  get categories1 => _categories1.value;
  set categories1(value) => _categories1.value = value;

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
    for (var entry in categories.entries) {
      List<Student> shuffledList = entry.value;
      shuffledList.shuffle();

      List<Student> newList = [];
      for (var student in shuffledList) {
        var alteredStudent = student;

        if (_loginState.currentUser.coders.contains(student.coderName)) {
          newList.insert(0, alteredStudent);
        } else {
          newList.add(alteredStudent);
        }
      }
      var category = Category(name: entry.key, values: newList);
      categories1.add(category);
      categories[entry.key] = newList;
    }
  }

  loadStudent(category, index) async {
    loadingStudentInfo = true;
    if (!(categories[category][index].loadFull)) {
      var x = await client.loadInfo(
          categories[category][index], _loginState.currentUser.token.uid);
      categories[category][index] = x;
    }
    loadingStudentInfo = false;
  }

  loadAndReturn(category, element) async {
    loadingStudentInfo = true;

    if ((element.loadFull)) {
      loadingStudentInfo = false;

      return element;
    } else {
      var x = await client.loadInfo(element, _loginState.currentUser.token.uid);
      loadingStudentInfo = false;
      for (var i = 0; i < categories[category].length; i++) {
        Student student = categories[category][i];
        if (student.coderName == element.coderName) {
          student = x;
        }
      }
      return x;
    }
  }

  paginateStudents(int index, String category) async {
    if (categories[category].length > 1 &&
        categories[category].length > index + 1) {
      if (!(categories[category][index + 1].loadFull)) {
        var subI = sublistIndex(index, category);
        List<Student> result = [];
        await Future.forEach(categories[category].sublist(index + 1, subI),
            (Student element) async {
          var x = await loadAndReturn(category, element);
          result.add(x);
        });

        categories[category].replaceRange(index + 1, subI, result);
      }

      await loadStudent(category, index);
    } else {
      await loadStudent(category, index);
    }
  }

  updateLikedCategory(String currentProject, String likedCategory) {
    client.updateLikedCategory(
        currentProject, likedCategory, _loginState.currentUser.token);
  }

  addToSeen(String coderName) async {
    var box = Hive.box('userPreferences');
    Map listOfSeen = box.get('listOfSeen');
    listOfSeen.addAll({coderName: true});
    await box.put('listOfSeen', listOfSeen);
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

  //returns the index based on the category list length
  int sublistIndex(index, category) {
    return (index + 4 > categories[category].length ||
            index == categories[category].length - 1)
        ? index + (categories[category].length - index)
        : index + 4;
  }
}
