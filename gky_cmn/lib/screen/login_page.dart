import 'package:gky_cmn/screen/admin_page.dart';
import 'package:gky_cmn/screen/home_page.dart';
import 'package:gky_cmn/screen/register_page.dart';

import '../std_lib.dart';
import '../login-widgets/export_login_widgets.dart';
import 'package:validators/validators.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
// input text controller ============================================
  TextEditingController emailController = TextEditingController();

// Form Key ======================================================
  final formKey = GlobalKey<FormState>();

// Widget Build =====================================================
  @override
  Widget build(BuildContext context) {
    final _height = displayHeight(context);

//Constructing widget =============================================

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
        autofocus: true,
        autocorrect: true,
        validator: (value) {
          if (!isEmail(value!)) {
            return 'Invalid Email';
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
      buttonText: 'Login',
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

// ================================= Platform Sign in =========================
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
                    signInLogoButtonGroup
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  loginEmail(String email) => {
        // http response

        if (formKey.currentState!.validate())
          {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Processing Data'))),

            if (emailController.text == 'admin@admin.com')
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AdminPage()))
            // HTTP Request Response
            else if (emailController.text == 'asd@asd.com')
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                  ModalRoute.withName('/loginPage'))
            else
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()))
          },
      };
  loginGmail() => {};
  loginHMS() => {};
  loginIOS() => {};
}
