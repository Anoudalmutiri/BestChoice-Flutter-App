class UserModel {
  int? id;
  String name;
  String email;
  String password;
  String major;
  String level;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.major,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'major': major,
      'level': level,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      major: map['major'],
      level: map['level'],
    );
  }
}