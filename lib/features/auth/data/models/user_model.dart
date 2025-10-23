import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required int id,
    required String username,
    String? name,
    String? sessionId,
    String? email,
  }) : super(
          id: id,
          username: username,
          name: name,
          sessionId: sessionId,
          email: email,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      sessionId: json['session_id'],
      email: json['email'],
    );
  }
}
