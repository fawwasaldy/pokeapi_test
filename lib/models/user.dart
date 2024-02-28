class User {
  final String id;
  final String email;
  final String password;

  User({
    required this.id,
    required this.email,
    required this.password,
  });

  // User.fromMap(dynamic obj) :
  //   id = obj['u_id'],
  //   email = obj['u_email'],
  //   password = obj['u_password'];

  Map<String, Object?> toMap() {
    return {
      'u_id': id,
      'u_email': email,
      'u_password': password,
    };
  }
}