import 'dart:convert';
import 'dart:io';

import 'package:chat_test_work/data/datasources/local_storage.dart';
import 'package:chat_test_work/domain/entities/massage.dart';
import 'package:chat_test_work/domain/entities/person.dart';
import 'package:chat_test_work/common/exception.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class RemoteDataSource {
  final LocalDataSource localDataSource = LocalDataSource();
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();
  final DatabaseReference _refUsers =
      FirebaseDatabase.instance.ref().child('users');
  final DatabaseReference _refMesseges =
      FirebaseDatabase.instance.ref().child('messages');

  Future<void> addUser(Person person) async {
    _refUsers.push().set(person.toJson());
  }

  Future<String?> changeCurrentUserPhoto(File newPhoto,
      [String? oldPhotoName]) async {
    String? urlDownloadIcon;

    try {
      UploadTask? uploadTaskIcon;

      //save newPhoto to FirebaseStorage
      var ref = FirebaseStorage.instance
          .ref()
          .child('icons/${path.basename(newPhoto.path)}');
      uploadTaskIcon = ref.putFile(File(newPhoto.path));

      var snapshotIcon = await uploadTaskIcon;
      urlDownloadIcon = await snapshotIcon.ref.getDownloadURL();
      //delete old Image
      if (oldPhotoName != '') {
        FirebaseStorage.instance.ref().child('icons/$oldPhotoName').delete();
      }
      // ignore: empty_catches
    } on FirebaseException {}
    return urlDownloadIcon;
  }

  Future<void> updateUser(Person user) async {
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

  Future<List<Person>> getUsers([List<int>? usersId]) async {
    var databaseEvent = await _refUsers.once();

    var dataSnapshot = databaseEvent.snapshot;
    List<Person> chatUsersList = [];

    if (dataSnapshot.exists) {
      final allUsersList = (dataSnapshot.value as Map<dynamic, dynamic>)
          .values
          .map((user) => Person.fromJson(user))
          .toList();

      if (usersId != null) {
        for (var id in usersId) {
          for (var user in allUsersList) {
            if (user.id == id) {
              chatUsersList.add(user);
            }
          }
        }
      } else {
        chatUsersList = allUsersList;
      }
    }
    return chatUsersList;
  }

  void sendMessage(Message message) {
    final chatId = message.idTo;
    _refMesseges.child(chatId.toString()).push().set(message.toJson());
  }

  Query getMessageQuery(int chatId) {
    return _refMesseges.child(chatId.toString());
  }

  Future<Uint8List?> getAvaImageFromRemote(String avatar) async {
    Uint8List? data;
    var ref = FirebaseStorage.instance.ref().child("icons/$avatar");
    try {
      data = await ref.getData(1024 * 1024);
      // ignore: empty_catches
    } on FirebaseException {}
    return data;
  }
}
