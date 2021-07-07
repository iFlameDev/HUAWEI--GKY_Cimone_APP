import 'package:flutter/material.dart';
import 'package:gky_cmn/font.dart';
import 'package:gky_cmn/sizes/sizes_helpers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../login-widgets/export_widgets.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _height = displayHeight(context);

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

    // ignore: prefer_const_constructors
    final password = PasswordInput(
      icon: FontAwesomeIcons.lock,
      hint: 'Password',
      inputAction: TextInputAction.done,
    );

    // ignore: prefer_const_constructors
    final loginBtn = RoundedButton(
      buttonText: 'Login',
    );

    final orSeparator = Row(mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [const Text('OR', style: kBodyText)]);

    // ignore: prefer_const_constructors
    final googleSignIn = SignInLogoButton(
        path: 'assets/logo-google.png', widthNum: 55, paddingNum: 5);

    // ignore: prefer_const_constructors
    final huaweiSignIn = SignInLogoButton(
        path: 'assets/logo-huawei.png', widthNum: 55, paddingNum: 10);

    // ignore: prefer_const_constructors
    final appleSignIn = SignInLogoButton(
        path: 'assets/logo-apple.png', widthNum: 50, paddingNum: 5);

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
                  password,
                  SizedBox(height: _height * 0.02),
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
}
