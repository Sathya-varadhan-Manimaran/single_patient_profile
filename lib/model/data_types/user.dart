import 'dart:convert';

class User {
  String name;
  String dateOfBirth;

  User(this.name, this.dateOfBirth);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateOfBirth': dateOfBirth,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['name'],
      map['dateOfBirth'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
