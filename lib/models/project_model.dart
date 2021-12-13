import 'dart:convert';

/// Represent a project of a student with basic details such as title, videoURL, language, and description
///
/// title - title of the game or application | STRING
/// videoURL - youtube video id or full url | STRING
/// language - coding language used for the project | STRING
/// description - a synopsis of the project | STRING
class Project {
  String title;
  String videoURL;
  String language;
  String description;
  String name;
  Project(
      {required this.title,
      required this.videoURL,
      required this.language,
      required this.description,
      required this.name});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'videoURL': videoURL,
      'language': language,
      'description': description,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map, String title, String name) {
    return Project(
        title: title,
        videoURL: map['video_url'],
        language: map['language'],
        description: map['desc'],
        name: name);
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Project(title: $title, videoURL: $videoURL)';
  }
}
