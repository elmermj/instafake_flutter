import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String? username;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? role;
  @HiveField(2)
  String? email;
  @HiveField(3)
  DateTime? createdAt;

  User({this.username, this.name, this.role, this.email, this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    role = json['role'];
    email = json['email'];
    createdAt = DateTime.parse(json['createdAt']);
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'name': name,
    'role': role,
    'email': email,
    'createdAt': createdAt!.toIso8601String(),
  };
}