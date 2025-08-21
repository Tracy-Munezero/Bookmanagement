import 'package:get_storage/get_storage.dart';

class StorageManager{
  static final GetStorage _storage = GetStorage();
  static bool saveUser(Map<String, dynamic> user) {
   List<dynamic> users = _storage.read('users') ?? [];
    users.add(user);
    _storage.write('users', users);
    return true;
  }
  static List <dynamic> getUsers() {
    return _storage.read('users') ?? [];
  }
//   static bool saveData(String key, Map value) {
//     _storage.write(key, value);
//     return true;
// }
// static dynamic getData() {
//    return _storage.read('user');

//   }
  // static void deleteData(String key) {
  //   _storage.remove(key);
  // }
}

