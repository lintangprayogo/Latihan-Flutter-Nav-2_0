import 'package:latihan_navigation_version_dua/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String stateKey = "state";
  final String userKey = "user";

  Future<bool> isLoggedIn() async {
    final prefrences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return prefrences.getBool(stateKey) ?? false;
  }

  Future<bool> login() async {
    final prefrences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return prefrences.setBool(stateKey, true);
  }

  Future<bool> logout() async {
    final prefrences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return prefrences.setBool(stateKey, false);
  }

  Future<bool> deleteUser() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setString(userKey, "");
  }

   Future<bool> saveUser(User user) async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setString(userKey, user.toJson());
  }

  Future<User?> getUser() async {
    final prefrences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    final json = prefrences.getString(userKey) ?? "";
    User? user;
    try {
      user = User.fromJson(json);
    } catch (e) {
      user = null;
    }

    return user;
  }
}
