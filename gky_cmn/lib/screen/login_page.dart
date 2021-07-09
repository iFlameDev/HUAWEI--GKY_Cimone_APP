import '../std_lib.dart';
import '../login-widgets/export_login_widgets.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _height = displayHeight(context);

//================ constructing widget =================

    final logo = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset('assets/logo-gky.png', height: _height * 0.3),
    ]);

    // ignore: prefer_const_constructors
    final email = TextInput(
      icon: FontAwesomeIcons.solidEnvelope,
      hint: 'Email',
      inputType: TextInputType.emailAddress,
      inputAction: TextInputAction.next,
    );

    final loginBtn = RoundedButton(
      buttonText: 'Login',
      onclick: () => loginEmail(email.getInput()),
    );

    final orSeparator =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: const Divider(
              color: Colors.white,
              height: 50,
            )),
      ),
      const Text('OR', style: kBodyText),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: const Divider(
              color: Colors.white,
              height: 50,
            )),
      ),
    ]);

    // ignore: prefer_const_constructors
    final googleSignIn = SignInLogoButton(
        path: 'assets/logo-google.png',
        widthNum: 55,
        paddingNum: 5,
        onclick: () => loginGmail());

    // ignore: prefer_const_constructors
    final huaweiSignIn = SignInLogoButton(
        path: 'assets/logo-huawei.png',
        widthNum: 55,
        paddingNum: 10,
        onclick: () => loginHMS());

    // ignore: prefer_const_constructors
    final appleSignIn = SignInLogoButton(
        path: 'assets/logo-apple.png',
        widthNum: 50,
        paddingNum: 5,
        onclick: () => loginIOS());

    final signInLogoButtonGroup = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [googleSignIn, huaweiSignIn, appleSignIn],
    );

//===================================== Layout ================================
    return Stack(
      children: [
        LoginBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              SizedBox(height: _height * 0.05),
              logo,
              // Login Form
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                children: [
                  email,
                  SizedBox(height: _height * 0.02),
                  // loginBtn,
                  loginBtn,
                  SizedBox(height: _height * 0.05),
                  orSeparator,
                  SizedBox(height: _height * 0.04),
                  signInLogoButtonGroup
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  loginEmail(String email) => {
        // http response
        print(email)
      };
  loginGmail() => {};
  loginHMS() => {};
  loginIOS() => {};
}
