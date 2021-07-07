import 'package:flutter/material.dart';

class SignInLogoButton extends StatelessWidget {
  @override
  const SignInLogoButton({
    required this.path,
    required this.widthNum,
    required this.paddingNum,
  });

  final String path;
  final double widthNum;
  final double paddingNum;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        width: widthNum,
        padding: EdgeInsets.all(paddingNum),
        alignment: Alignment.center,
        child: Image.asset(
          path,
        ),
      ),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: Colors.white,
      ),
    );
  }
}
