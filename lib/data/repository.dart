import 'dart:io';

import 'package:chat_test_work/data/datasources/local_storage.dart';
import 'package:chat_test_work/data/datasources/remote_storage.dart';
import 'package:chat_test_work/domain/entities/person.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class Repository {
  LocalDataSource localDataSource = LocalDataSource();
  RemoteDataSource remoteDataSource = RemoteDataSource();

  Future<Person> getCurrentUser() async {
    return await localDataSource.getCurrentUserFromCache();
  }

  Future<List<Person>> getAllUsers() async {
    return await remoteDataSource.getUsers();
  }

  Future<List<Person>> getCurrentChatUsers(List<int> usersId) async {
    return await remoteDataSource.getUsers(usersId);
  }

  Future<void> addCurrentUser(Person user) async {
    await localDataSource.currentUserToCache(user);
    await remoteDataSource.addUser(user);
  }

  Future<String?> changeCurrentUserPhoto(File newPhoto,
      [String? oldPhotoName]) async {
    return await remoteDataSource.changeCurrentUserPhoto(
        newPhoto, oldPhotoName);
  }

  Future<void> updateCurrentUser(Person user) async {
    await localDataSource.currentUserToCache(user);
    await remoteDataSource.updateUser(user);
  }

  Query getMessagesQuery(int chatId) {
    return remoteDataSource.getMessageQuery(chatId);
  }

  Future<void> saveAvatarImages(List<String> chatUsersAvatarNames) async {
    if (chatUsersAvatarNames.isNotEmpty) {
      for (String avatarName in chatUsersAvatarNames) {
        final Uint8List? data =
            await remoteDataSource.getAvaImageFromRemote(avatarName);
        await localDataSource.saveImageToCache(avatarName, data);
      }
    }
  }

  Future<String> getAvatarImage(String avaLink) async {
    String avaInBase64 = await localDataSource.getImageFromPreferences(avaLink);
    return avaInBase64;
  }
}
