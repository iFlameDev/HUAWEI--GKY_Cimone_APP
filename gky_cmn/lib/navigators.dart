// ignore: import_of_legacy_library_into_null_safe
import 'package:gky_cmn/screen/register_page.dart';
import 'package:gky_cmn/std_lib.dart';

class Navigators {
  toHomePage(UserData userData, BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HomePage(userData: userData)));
  }

  toRegisterPage(UserData userData, BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterPage(
                  userData: userData,
                )));
  }

  toLoginPage(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
