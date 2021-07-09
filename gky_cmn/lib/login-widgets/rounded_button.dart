import 'package:flutter/material.dart';

import '../font.dart';

class RoundedButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RoundedButton({required this.buttonText, required this.onclick});

  final VoidCallback onclick;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(
        onPressed: () => onclick(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            buttonText,
            style: kBodyText,
          ),
        ),
      ),
    );
  }
}
