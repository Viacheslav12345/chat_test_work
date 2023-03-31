import 'package:chat_test_work/data/datasources/local_storage.dart';
import 'package:chat_test_work/data/datasources/remote_storage.dart';
import 'package:chat_test_work/domain/entities/person.dart';

class Repository {
  LocalDataSource localDataSource = LocalDataSource();
  RemoteDataSource remoteDataSource = RemoteDataSource();

  Future<Person> getCurrentUser() async {
    return await localDataSource.getCurrentUserFromCache();
  }

  Future<List<Person>> getAllUsers() async {
    return await remoteDataSource.getUsers();
  }

  void addCurrentUser(Person user) {
    localDataSource.currentUserToCache(user);
    remoteDataSource.addUser(user);
  }

  void updateCurrentUser(Person user) {
    localDataSource.currentUserToCache(user);
    remoteDataSource.updateUser(user);
  }

  Future<void> saveAvatarImages(List<String> allUsersAvatars) async {
    await remoteDataSource
        .getImagesEncodeToBase64AndSaveToLocal(allUsersAvatars);
  }

  Future<String> getAvatarImage(String avaLink) async {
    String avaInBase64 = await localDataSource.getImageFromPreferences(avaLink);
    return avaInBase64;
  }
}
