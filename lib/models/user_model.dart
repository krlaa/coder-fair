import 'dart:convert';

/// User class to organize a user this can include parents, judges, coaches and owners
///
/// role - value based from 1-5; This indicates the weight of your vote | INT
/// coderName - non PII (should it be tied to a private file so we know who is who?) | STRING
class User {
  int role;
  String coderName;

  User({required this.role, required this.coderName});

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'coderName': coderName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      role: map['role'],
      coderName: map['coderName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(role: $role, coderName: $coderName)';
}
