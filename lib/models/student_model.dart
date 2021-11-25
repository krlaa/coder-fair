import 'dart:convert';
import 'user_model.dart';
import 'project_model.dart';

/// Represents a student. Contains necessary information to identify within the app as well details about their project(s)
///
/// coderName - refer [User]
/// profilePictureURL - profile picture url of Student | STRING
/// listOfProjects - will contain a list of [Project]s | List<Project>
/// codeCoach - name of coach | STRING
/// thumbnailURL - image URL of game to put on the [HOME SCREEN] card
class Student {
  String coderName;
  String profilePictureURL;
  List<Project> listOfProjects;
  String codeCoach;
  String thumbnailURL;
  Student(
      {required this.coderName,
      required this.profilePictureURL,
      required this.listOfProjects,
      required this.codeCoach,
      required this.thumbnailURL});

  Map<String, dynamic> toMap() {
    return {
      'coderName': coderName,
      'profilePictureURL': profilePictureURL,
      'listOfProjects': listOfProjects.map((x) => x.toMap()).toList(),
      'codeCoach': codeCoach,
      'thumbnailURL': thumbnailURL,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      coderName: map['coderName'],
      profilePictureURL: map['profilePictureURL'],
      listOfProjects: List<Project>.from(
          map['listOfProjects']?.map((x) => Project.fromMap(x))),
      codeCoach: map['codeCoach'],
      thumbnailURL: map['thumbnailURL'],
    );
  }

  String toJson() => json.encode(toMap());

  static List<Student> fromJson(String source) {
    return json.decode(source).map<Student>((x) {
      return Student.fromMap(x);
    }).toList();
  }

  @override
  String toString() {
    return 'Student(coderName: $coderName,  listOfProjects: $listOfProjects, codeCoach: $codeCoach, )';
  }
}
