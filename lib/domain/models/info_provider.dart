import 'dart:math';

import 'package:chat_test_work/data/repository.dart';
import 'package:chat_test_work/domain/entities/person.dart';
import 'package:flutter/cupertino.dart';

class InfoProvider extends ChangeNotifier {
  Repository repository = Repository();

  Person get currentUser => _currentUser;
  List<Person> get allUsers => _allUsers;
  Map<String, String> get imagesInBase64 => _imagesInBase64;
  static Person _currentUser = Person(
    id: 0,
    name: '',
    avatar: '',
    urlAvatar: '',
    profession: '',
    lastSeen: '',
  );
  List<Person> _allUsers = [];
  final Map<String, String> _imagesInBase64 = {};
  late int _chatId;

  Future<void> newCurrentUser() async {
    int lastId = 0;
    await getAllUsers();
    final usersListId = allUsers.map((user) => user.id).toList();
    if (usersListId.isNotEmpty) {
      lastId = usersListId.reduce(max);
    }
    currentUser.id = lastId + 1;
    currentUser.lastSeen = DateTime.now().millisecondsSinceEpoch.toString();
    saveCurrentUser(currentUser);
  }

  Future<Person> getCurrentUser() async {
    _currentUser = await repository.getCurrentUser();
    if (_currentUser.id == 0) {
      newCurrentUser();
    }
    notifyListeners();
    return _currentUser;
  }

  Future<void> getAllUsers() async {
    _allUsers = await repository.getAllUsers().whenComplete(
        () => saveAvatarsToCache().then((value) => allUsers.map((user) async {
              _imagesInBase64[user.avatar] =
                  await getImageFromCache(user.avatar);
            })));

    notifyListeners();
  }

  void saveCurrentUser(Person currentUser) {
    _currentUser = currentUser;
    repository.addCurrentUser(currentUser);
  }

  void updateCurrentUser(Person currentUser) {
    _currentUser = currentUser;
    repository.updateCurrentUser(_currentUser);
  }

  void setCurrentChatId(int chatId) {
    _chatId = chatId;
  }

  int getCurrentChatId() {
    return _chatId;
  }

  Future<void> saveAvatarsToCache() async {
    List<String> allUsersAvatar = allUsers.map((user) => user.avatar).toList();
    await repository.saveAvatarImages(allUsersAvatar);
  }

  Future<String> getImageFromCache(String linkAvatar) async {
    final avaInBase64 = repository.getAvatarImage(linkAvatar);
    return await avaInBase64;
  }
}
