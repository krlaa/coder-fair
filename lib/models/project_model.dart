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

  Project(
      {required this.title,
      required this.videoURL,
      required this.language,
      required this.description});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'videoURL': videoURL,
      'language': language,
      'description': description,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      title: map['title'],
      videoURL: map['videoURL'],
      language: map['language'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Project(title: $title)';
  }
}