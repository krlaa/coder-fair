import 'dart:convert';

import 'package:coder_fair/controllers/api_controller.dart';
import 'package:coder_fair/models/role_model.dart';

/// User class to organize a user this can include parents, judges, coaches and owners
///
/// role - value based from 1-5; This indicates the weight of your vote | INT
/// coderName - non PII (should it be tied to a private file so we know who is who?) | STRING
class User {
  APIClient client = APIClient();
  Role role;
  List coders;
  String full_name;

  UserPayload token;

  User({
    this.coders = const [],
    required this.role,
    this.full_name = "",
    required this.token,
  });

  factory User.fromMap(Map<String, dynamic> map, UserPayload info) {
    return User(
        role: Role.fromString(map['role']),
        coders: map['coder'] ?? List.empty(),
        // TODO: change to name
        full_name: map['full_name'],
        token: info);
  }

  factory User.fromJson(String source, UserPayload info) =>
      User.fromMap(json.decode(source), info);

  @override
  String toString() => 'User(role: $role, coderName: $coders)';

  increaseLikeCount() {
    client.increaseLikeCount();
  }
}
