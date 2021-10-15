import 'package:gky_cmn/std_lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cookies {
  saveLoginCookies(UserData userData) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user', userData.UserDataToJSON());
  }

  Future<UserData> getLoginCookies() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    dynamic json = pref.getString('user');
    UserData userData = UserData();
    userData.GetUserDataFromJSON(json);

    return userData;
  }

  removeLoginCookies() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.remove('user');
  }

  Future<bool> isLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.containsKey('user');
  }
}
