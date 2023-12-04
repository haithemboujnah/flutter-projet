class User {
  String id;
  String username;
  String password;
  bool isAdmin;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'isAdmin': isAdmin ? 1 : 0,
    };
  }
}
