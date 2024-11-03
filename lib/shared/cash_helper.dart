import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';

class CashHelper {
  static late GetStorage _storage;

  static init() {
    _storage = GetStorage();
  }

  static const String _token = 'token';
  static const String _user = 'user';

  static saveUserToken({required String token}) {
    _storage.write(_token, token);
  }

  static String? getUserToken() {
    return _storage.read(_token);
  }

  static saveUser({required UserModel user}) {
    _storage.write(_user, user.toJson());
  }

  static getUser() {
    return _storage.read(_user);
  }
}
