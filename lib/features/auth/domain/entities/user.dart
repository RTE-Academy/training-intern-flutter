class User {
  final int id;
  final String username;
  final String? name;
  final String? email;
  final String? sessionId;
  final String? password;

  const User({
    required this.id,
    required this.username,
    this.name,
    this.email,
    this.sessionId,
    this.password,
  });
}
