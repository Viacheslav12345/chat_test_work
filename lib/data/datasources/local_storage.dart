// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:chat_test_work/domain/entities/person.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_CURRENT_USER = 'CACHED_CURRENT_USER';
const CACHED_ALL_USERS_AVATAR = 'CACHED_ALL_USERS_AVATAR';

class LocalDataSource {
  Future<void> currentUserToCache(Person person) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonCurrentUser = json.encode(person.toJson());
    prefs.setString(CACHED_CURRENT_USER, jsonCurrentUser);
  }

  Future<Person> getCurrentUserFromCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear(); // delete local info
    final jsonCurrentUser = prefs.getString(CACHED_CURRENT_USER) ?? '';
    if (jsonCurrentUser.isNotEmpty) {
      return Future.value(Person.fromJson(json.decode(jsonCurrentUser)));
    } else {
      return Person(
          id: 0,
          name: '',
          avatar: '',
          urlAvatar: '',
          profession: '',
          lastSeen: '');
      // throw CacheException();
    }
  }

  // Future<void> saveImagesToPreferences(List<String> listBase64) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   List<String> currentImagesIn64 = await getImagesFromPreferences();

  //   for (var imageIn64 in listBase64) {
  //     if (currentImagesIn64.contains(imageIn64)) {
  //     } else {
  //       currentImagesIn64.add(imageIn64);
  //     }
  //   }
  //   prefs.setStringList(
  //       CACHED_ALL_USERS_AVATAR, currentImagesIn64); // adding the new image
  // }

  Future<String> getImageFromPreferences(String avaLink) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var avaInBase64 = prefs.getString(CACHED_ALL_USERS_AVATAR + avaLink);
    if (avaInBase64 != null) {
      return avaInBase64;
    } else {
      return '';
    }
  }
}
