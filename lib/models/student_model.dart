import 'dart:convert';

import 'project_model.dart';
import 'user_model.dart';

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

  Student({
    this.coderName = "",
    this.profilePictureURL = "",
    this.listOfProjects = const [],
    this.codeCoach = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'coderName': coderName,
      'profilePictureURL': profilePictureURL,
      'listOfProjects': listOfProjects.map((x) => x.toMap()).toList(),
      'codeCoach': codeCoach,
    };
  }

  @override
  String toString() {
    return 'Student(coderName: $coderName, profilePictureURL: $profilePictureURL, listOfProjects: $listOfProjects, codeCoach: $codeCoach)';
  }
}
