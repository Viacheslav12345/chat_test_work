// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:firebase_auth/firebase_auth.dart';

class Person {
  int id;
  String name;
  String avatar;
  String urlAvatar;
  String profession;
  String lastSeen;
  Person({
    required this.id,
    required this.name,
    required this.avatar,
    required this.profession,
    required this.lastSeen,
    required this.urlAvatar,
  });

  factory Person.fromJson(Map<dynamic, dynamic> json) => Person(
        id: json['id'],
        name: json['name'] ?? '',
        avatar: json['avatar'] ?? '',
        urlAvatar: json['urlAvatar'] ?? '',
        profession: json['profession'] ?? '',
        lastSeen: json['lastSeen'] ?? '',
      );

  Map<dynamic, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar': avatar,
        'urlAvatar': urlAvatar,
        'profession': profession,
        'lastSeen': lastSeen,
      };

  // Person.fromFirebase(User user) {
  //   id = user.uid;
  // }
}
