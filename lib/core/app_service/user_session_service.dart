import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../config/app_constants.dart';
import '../../features/auth/models/user_model.dart';

class UserSessionService {
  UserSessionService._();

  static final GetStorage _storage = GetStorage();

  static Future<void> saveUser(UserModel user) async {
    await _storage.write(AppConstants.isLoggedIn, true);
    await _storage.write('cached_user', jsonEncode(user.toJson()));
  }

  static UserModel? getCachedUser() {
    final String? userJson = _storage.read('cached_user');
    if (userJson == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(userJson));
    } catch (_) {
      return null;
    }
  }

  static Future<void> clearSession() async {
    await _storage.write(AppConstants.isLoggedIn, false);
    await _storage.remove('cached_user');
  }

  static bool get isLoggedIn =>
      _storage.read(AppConstants.isLoggedIn) ?? false;
}
