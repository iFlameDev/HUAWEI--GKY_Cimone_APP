import 'package:flutter/material.dart';

class SignInLogoButton extends StatefulWidget {
  @override
  const SignInLogoButton({
    required this.path,
    required this.widthNum,
    required this.paddingNum,
    required this.onclick,
  });

  final VoidCallback onclick;
  final String path;
  final double widthNum;
  final double paddingNum;

  @override
  State<SignInLogoButton> createState() => _SignInLogoButtonState();
}

class _SignInLogoButtonState extends State<SignInLogoButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        width: widget.widthNum,
        padding: EdgeInsets.all(widget.paddingNum),
        alignment: Alignment.center,
        child: Image.asset(
          widget.path,
        ),
      ),
      onPressed: () {
        widget.onclick;
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: Colors.white,
      ),
    );
  }
}
