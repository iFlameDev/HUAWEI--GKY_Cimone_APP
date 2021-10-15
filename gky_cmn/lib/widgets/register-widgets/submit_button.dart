import 'package:gky_cmn/std_lib.dart';

class SubmitButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SubmitButton({required this.buttonText, required this.onclick});

  final VoidCallback onclick;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
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
