import '../../data/models/user_model.dart';

class User {
  final int id;
  final String username;
  final String? name;
  final String? email;
  final String? sessionId;
  final String? requestToken;

  const User({
    required this.id,
    required this.username,
    this.name,
    this.email,
    this.sessionId,
    this.requestToken,
  });

  factory User.fromModel(UserModel model) {
    return User(
      id: model.id,
      username: model.username,
      name: model.name,
      email: model.email,
      sessionId: model.sessionId,
      requestToken: model.requestToken,
    );
  }
}
