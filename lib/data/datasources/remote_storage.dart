import 'dart:convert';

import 'package:chat_test_work/data/datasources/local_storage.dart';
import 'package:chat_test_work/domain/entities/massage.dart';
import 'package:chat_test_work/domain/entities/person.dart';
import 'package:chat_test_work/common/exception.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteDataSource {
  final LocalDataSource localDataSource = LocalDataSource();
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();
  final DatabaseReference _refUsers =
      FirebaseDatabase.instance.ref().child('users');
  final DatabaseReference _refMesseges =
      FirebaseDatabase.instance.ref().child('messages');

  void addUser(Person person) async {
    _refUsers.push().set(person.toJson());
  }

  void updateUser(Person user) async {
    String? userKey;
    var databaseEvent = await _refUsers.once();
    var dataSnapshot = databaseEvent.snapshot;
    if (dataSnapshot.exists) {
      var mapEntry = (dataSnapshot.value as Map<dynamic, dynamic>)
          .entries
          .firstWhere(
              (element) => Person.fromJson(element.value).id == user.id);
      userKey = mapEntry.key as String;
    } else {
      ServerException('User not Found');
    }
    if (userKey != null) {
      await _ref.child('users/$userKey').update({
        "name": user.name,
        "profession": user.profession,
        "lastSeen": user.lastSeen,
        "avatar": user.avatar,
        "urlAvatar": user.urlAvatar,
      });
    }
  }

  Future<List<Person>> getUsers() async {
    var databaseEvent = await _refUsers.once();

    var dataSnapshot = databaseEvent.snapshot;
    List<Person> usersList = [];
    if (dataSnapshot.exists) {
      usersList = (dataSnapshot.value as Map<dynamic, dynamic>)
          .values
          .map((user) => Person.fromJson(user))
          .toList();
    }
    return usersList;
  }

  void sendMessage(Message message) {
    _refMesseges.push().set(message.toJson());
  }

  Query getMessageQuery() {
    return _refMesseges;
  }

  Future<void> getImagesEncodeToBase64AndSaveToLocal(
      List<String> allUsersAvatar) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (allUsersAvatar.isNotEmpty) {
      for (var avatar in allUsersAvatar) {
        if (avatar != '') {
          var ref = FirebaseStorage.instance.ref().child("icons/$avatar");
          Uint8List? data;
          try {
            data = await ref.getData(1024 * 1024);
            // ignore: empty_catches
          } on FirebaseException {}

          if (data != null) {
            String base64String = base64Encode(data);
            prefs.setString(CACHED_ALL_USERS_AVATAR + avatar, base64String);
          }
        }
      }
    }
  }
}
