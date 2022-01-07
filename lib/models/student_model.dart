import 'package:collection/collection.dart';

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
  String first_name;
  String codeCoach;
  bool loadFull;
  bool eligible;
  late bool seen = false;

  Student(
      {this.coderName = "",
      this.first_name = "",
      this.profilePictureURL = "",
      this.listOfProjects = const [],
      this.codeCoach = "",
      this.loadFull = false,
      this.eligible = false});

  set seenStudent(value) => this.seen = value;

  factory Student.fromJson(Map<String, dynamic> parsedJson, String name) {
    return Student(
        codeCoach: parsedJson["coach"] ?? "",
        first_name: parsedJson["first_name"] ?? "",
        coderName: name,
        eligible: parsedJson["eligible"] ?? "",
        profilePictureURL: parsedJson["coder_pic_url"] ?? "");
  }
  @override
  String toString() {
    return 'loadFull: $loadFull)';
  }

  Student copyWith(
      {String? coderName,
      String? profilePictureURL,
      List<Project>? listOfProjects,
      String? codeCoach,
      String? first_name,
      bool? loadFull,
      bool? eligible}) {
    return Student(
      eligible: eligible ?? this.eligible,
      first_name: first_name ?? this.first_name,
      coderName: coderName ?? this.coderName,
      profilePictureURL: profilePictureURL ?? this.profilePictureURL,
      listOfProjects: listOfProjects ?? this.listOfProjects,
      codeCoach: codeCoach ?? this.codeCoach,
      loadFull: loadFull ?? this.loadFull,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Student &&
        other.coderName == coderName &&
        other.profilePictureURL == profilePictureURL &&
        listEquals(other.listOfProjects, listOfProjects) &&
        other.codeCoach == codeCoach &&
        other.loadFull == loadFull;
  }

  @override
  int get hashCode {
    return coderName.hashCode ^
        profilePictureURL.hashCode ^
        listOfProjects.hashCode ^
        codeCoach.hashCode ^
        loadFull.hashCode;
  }
}
