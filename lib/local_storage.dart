import 'package:get_storage/get_storage.dart';

class StorageManager{
  static final GetStorage _storage = GetStorage();
  static bool saveData(String key, Map value) {
    _storage.write(key, value);
    return true;
}
static dynamic getData(String key) {
   return _storage.read('user');

  }
  // static void deleteData(String key) {
  //   _storage.remove(key);
  // }
}

