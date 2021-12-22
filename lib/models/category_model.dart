import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:coder_fair/models/student_model.dart';

class CategoryList {
  late List<Category> _categories = [];

  get categories => _categories;
  set categories(value) => _categories = value;

  void add(Category category) {
    _categories.add(category);
  }

  get keys => _categories.map((x) => x.name).toList();
  get values => _categories.map((x) => x.values).toList();
  @override
  String toString() => 'CategoryList(_categories: $_categories)';
}

class Category {
  String name;
  List<Student> values;
  int currentIndex;

  Category({
    required this.name,
    required this.values,
    this.currentIndex = 0,
  });

  void changeIndex(int value) => currentIndex = value;

  Category copyWith({
    String? name,
    List<Student>? values,
    int? currentIndex,
  }) {
    return Category(
      name: name ?? this.name,
      values: values ?? this.values,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  String toString() =>
      'Category(name: $name, values: $values, currentIndex: $currentIndex)';
}
