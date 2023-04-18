import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chat_test_work/data/repository.dart';
import 'package:chat_test_work/domain/entities/massage.dart';
import 'package:chat_test_work/domain/entities/person.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;

class InfoProvider extends ChangeNotifier {
  Repository repository = Repository();

  Person get currentUser => _currentUser;
  List<Person> get currentChatUsers => _currentChatUsers;
  int get chatId => _chatId;

  static Person _currentUser = Person(
    id: 0,
    name: '',
    avatar: '',
    urlAvatar: '',
    profession: '',
    lastSeen: '',
  );
  List<Person> _currentChatUsers = [];
  late int _chatId;

  Future<void> addNewCurrentUser() async {
    int lastUserId = 0;
    final allUsers = await getAllUsers();
    final usersListId = allUsers.map((user) => user.id).toList();
    if (usersListId.isNotEmpty) {
      lastUserId = usersListId.reduce(max);
    }
    _currentUser.id = lastUserId + 1;
    _currentUser.lastSeen = DateTime.now().millisecondsSinceEpoch.toString();
    await repository.addCurrentUser(_currentUser);
    notifyListeners();
  }

  Future<void> getCurrentUser() async {
    _currentUser = await repository.getCurrentUser();
    if (_currentUser.id == 0) {
      addNewCurrentUser();
    }
    notifyListeners();
  }

  Future<void> getCurrentChatUsers() async {
    var currentChatQuery = repository.getMessagesQuery(chatId);
    DataSnapshot dataSnapshot = await currentChatQuery.get();
    List<int> currentChatUsersId = [];

    if (dataSnapshot.exists) {
      final currentChatMessages = (dataSnapshot.value as Map<dynamic, dynamic>)
          .values
          .map((json) => Message.fromJson(json))
          .toList();
      final setId =
          currentChatMessages.map((message) => message.idFrom).toSet();
      currentChatUsersId = setId.toList();
      currentChatUsersId.removeWhere((element) => element == currentUser.id);
      _currentChatUsers =
          await repository.getCurrentChatUsers(currentChatUsersId);
    }
    notifyListeners();
  }

  Future<List<Person>> getAllUsers() async {
    return await repository.getAllUsers();
  }

  Future<void> changeCurrentUserPhoto(File? newPhoto) async {
    if (newPhoto != null) {
      _currentUser.urlAvatar = await repository.changeCurrentUserPhoto(
              newPhoto, currentUser.avatar) ??
          _currentUser.urlAvatar;
      _currentUser.avatar = path.basename(newPhoto.path);
      updateCurrentUser(_currentUser);
    }
    notifyListeners();
  }

  Future<void> updateCurrentUser(Person currentUser) async {
    _currentUser = currentUser;
    await repository.updateCurrentUser(_currentUser);
    notifyListeners();
  }

  Future<void> setIdAndloadInfoForChat(String chatId) async {
    _chatId = int.parse(chatId);
    await getCurrentChatUsers();
    await saveChatAvatarsToCache();
  }

  Future<void> saveChatAvatarsToCache() async {
    List<String> chatUsersAvatarNames = [];
    for (var user in currentChatUsers) {
      if (user.avatar.isNotEmpty) {
        chatUsersAvatarNames.add(user.avatar);
      }
    }
    await repository.saveAvatarImages(chatUsersAvatarNames);
  }

  Future<Map<String, Image>> getImageFromCache() async {
    Map<String, Image> chatAvaImages = {};
    final chatAvaNames = currentChatUsers.map((user) => user.avatar).toList();
    for (var avaName in chatAvaNames) {
      if (avaName.isNotEmpty) {
        final avaInBase64 = await repository.getAvatarImage(avaName);
        // final avaInUnit8 = const Base64Decoder().convert(avaInBase64);
        final avaImage = Image.memory(
            const Base64Decoder().convert(avaInBase64),
            fit: BoxFit.cover);
        if (avaName != currentUser.avatar) {
          chatAvaImages.putIfAbsent(avaName, () => avaImage);
        }
      }
    }
    return chatAvaImages;
  }
}
