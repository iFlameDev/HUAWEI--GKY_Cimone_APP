import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../std_lib.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  autoLogin() async {
    if (await Cookies().isLogin()) {
      userData = await Cookies().getLoginCookies();
      Navigators().toHomePage(userData, context);
    }
  }

// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< User data >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  UserData userData = UserData();

// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< INIT STATE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// =================================================================================

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< input text controller >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  TextEditingController emailController = TextEditingController();

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<google Login Controller>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  final googleLoginController = Get.put(GoogleLoginController());

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Form Key >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  final formKey = GlobalKey<FormState>();

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Widget Build >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  @override
  Widget build(BuildContext context) {
    final _height = displayHeight(context);

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Constructing widget >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

//=========================== LOGO GKY ====================================
    final logo = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset('assets/logo-gky.png', height: _height * 0.3),
    ]);

//=========================== Email Input Text Box ===================================
    // ignore: prefer_const_constructors
    final email = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        controller: emailController,
        autocorrect: true,
        validator: (value) {
          if (!isEmail(value!)) {
            return 'Email tidak valid';
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          focusColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          hintText: 'Email',
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              FontAwesomeIcons.solidEnvelope,
              color: Colors.white,
              size: 30,
            ),
          ),
          hintStyle: kBodyText,
        ),
        style: kBodyText,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      ),
    );

//================================= Login Button =======================================
    final loginBtn = RoundedButton(
      buttonText: 'Masuk',
      onclick: () => loginEmail(emailController.text),
    );

//========================== Separator ----- OR ----- ==============================
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
      const Text('Masuk menggunakan', style: kBodyText),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: const Divider(
              color: Colors.white,
              height: 50,
            )),
      ),
    ]);

// ================================= Platform Sign in =========================

    // GOOGLE SIGN IN NOT IMPLEMENTED
    // ignore: prefer_const_constructors
    final googleSignIn = FloatingActionButton.extended(
      onPressed: () {
        loginGoogle();
      },
      icon: Image.asset(
        'assets/logo-google.png',
        height: 32,
        width: 32,
      ),
      label: Text('Sign in with Google'),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );

    // final huaweiSignInBtn = HuaweiIdAuthButton(
    //   onPressed: () async {
    //     loginHMS();
    //   },
    //   borderRadius: AuthButtonRadius.MEDIUM,
    // );

    // final huaweiSignIn = Container(
    //   child: (userData.serviceAvailability.getHMSavailability())
    //       ? huaweiSignInBtn
    //       : Container(),
    // );

    // APPLE SIGN IN NOT IMPLEMENTED
    // ignore: prefer_const_constructors
    // final appleSignIn = SignInLogoButton(
    //     path: 'assets/logo-apple.png',
    //     widthNum: 50,
    //     paddingNum: 5,
    //     onclick: () => loginIOS());

    // SIGN IN GROUP NOT IMPLEMENTED
    // final signInLogoButtonGroup = Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     /*googleSignIn,*/ huaweiSignIn, /*appleSignIn*/
    //   ],
    // );

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
              Form(
                key: formKey,
                child: ListView(
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
                    googleSignIn,
                    SizedBox(height: _height * 0.04),
                    // huaweiSignInBtn
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{  LOGIN EMAIL  }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
  loginEmail(String email) {
    // http response

    if (formKey.currentState!.validate()) {
      userData.email = emailController.text;
      if (userData.email == 'admin@admin.com') {
        // admin login, go to admin page
        // Message
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Masuk sebagai admin')));

        // Moving page
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminPage(
                      userData: userData,
                    )));
      } else {
        loginOrRegis();
      }
    }
    ;
  }

//{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{    LOGIN HUAWEI     }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
  // loginHMS() async {
  //   AccountAuthParamsHelper helper = AccountAuthParamsHelper();
  //   helper
  //     ..setAccessToken()
  //     ..setEmail()
  //     ..setIdToken()
  //     ..setAuthorizationCode()
  //     ..setProfile();
  //   try {
  //     userData.loginData.huaweiAccount =
  //         await AccountAuthService.signIn(helper);
  //   } on Exception catch (e) {
  //     print(e);
  //     await DialogError()
  //         .show(CodeStatus(code: '123', status: e.toString()), context);
  //     return;
  //   }
  //   // print('lewat');
  //   userData.email = userData.loginData.huaweiAccount!.email;
  //   userData.name = userData.loginData.huaweiAccount!.givenName;

  //   loginOrRegis();
  // }

// {{{{{{{{{{{{{{{{{{{{{{{{{{{    LOGIN OR REGIS DECISION    }}}}}}}}}}}}}}}}}}}}}}}}}}}
  loginOrRegis() async {
    // print('masuk login or regis');
    // print(userData.email);
    // print(userData.loginData.huaweiAccount.displayName);

    //HTTP REQ
    await loginRequest();
    // print(userData.email);
    // print(userData.address);
    // print(userData.name);
    print('CONSOLE kelar REQUEST');

    // kalau sudah ada di system
    // HOMEPAGE
    if (codeStatus.code == '001') {
      print(codeStatus);
      Navigators().toHomePage(userData, context);
    }
    // belum ada di system
    // REGISTRATION_PAGE
    else if (codeStatus.code == '002') {
      print(codeStatus);
      await DialogRegister().show(context);
      // moving page
      Navigators().toRegisterPage(userData, context);
    } else {
      print(codeStatus);
      setState(() {});
    }
  }

// \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\   HTTP Request   ////////////////////////////////
// Temp codeStatus
  CodeStatus codeStatus = CodeStatus();

  // Temp response
  // ignore: prefer_typing_uninitialized_variables
  var response;
  Future<void> loginRequest() async {
    print('CONSOLE masuk loginRequest');
    try {
      response = await http.post(
        Uri.parse('${rootJemaat}masuk'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': userData.email!,
        }),
      );
    } on Exception catch (e) {
      print(e);
    }
    print('CONSOLE SELESAI FETCH');
    print(response.body);
    print('teler');
    // get Code Status
    codeStatus.getCodeStatus(response.body);
    print(codeStatus.code);
    if (codeStatus.code == '001') {
      print(codeStatus);
      userData.GetUserDataFromJSON(response.body);
    }
    print("Done");
  }

  loginGoogle() async {
    await googleLoginController.login();

    userData.email = googleLoginController.googleAccount.value?.email ?? '';
    userData.name =
        googleLoginController.googleAccount.value?.displayName ?? '';

    print(userData.email);
    print(userData.name);
    loginOrRegis();
  }

  loginIOS() {
    // print('IOS');
  }
}
