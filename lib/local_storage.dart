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

  static bool saveBook(Map<String, dynamic> book) {
    List<dynamic> books = _storage.read('books') ?? [];
    books.add(book);
    _storage.write('books', books);
    return true;
  }

  static List<dynamic> getBooks(){
    return _storage.read('books') ?? [];
  }
  static void deleteBook(String imagePath) {
    List<dynamic> books = getBooks();
    books.removeWhere((b) => b['imagePath'] == imagePath);
    _storage.write('books', books);
  }
  static void updateBook(Map<String, dynamic> updatedBook) {
      List<dynamic> books = getBooks();

      for (int i = 0; i < books.length; i++) {
        if (books[i]['imagePath'] == updatedBook['imagePath']) {
          books[i] = updatedBook;
          break;
        }
      }

      _storage.write('books', books);
    }

    // Save a single current logged-in user
  static bool saveCurrentUser(Map<String, dynamic> user) {
    _storage.write('currentUser', user);
    return true;
  }

  // Get the currently logged-in user
  static Map<String, dynamic>? getCurrentUser() {
    final user = _storage.read('currentUser');
    if (user != null) {
      return Map<String, dynamic>.from(user);
    }
    return null;
  }

  // Logout / remove current user
  static void logoutCurrentUser() {
    _storage.remove('currentUser');
  }
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


