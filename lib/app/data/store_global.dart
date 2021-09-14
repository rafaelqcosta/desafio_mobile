import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreGlobal {
  SharedPreferences? preferences;

  Future<void> salvarCredenciais(User user) async {
    try {
      preferences = await SharedPreferences.getInstance();
      await preferences!.setString('user_email', user.email!);
      await preferences!.setString('user_uid', user.uid);
    } catch (e) {
      print(e);
    }
  }

  Future<String?> getUserEmail() async {
    SharedPreferences? preferences;
    preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('user_email')) {
      return preferences.getString('user_email').toString();
    }
  }

  Future<String?> getUserUid() async {
    SharedPreferences? preferences;
    preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('user_uid')) {
      return preferences.getString('user_uid').toString();
    }
  }

  Future<String?> apagarCredenciais() async {
    SharedPreferences? preferences;
    preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
