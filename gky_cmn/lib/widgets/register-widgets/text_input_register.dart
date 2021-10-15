import 'package:gky_cmn/std_lib.dart';

class TextInput extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  TextInput({
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
    // required this.maxLines,
  });

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  // final int maxLines;

  final input = TextEditingController();

  @override
  State<TextInput> createState() => _TextInputState();

  String getInput() {
    return input.text;
  }
}

class _TextInputState extends State<TextInput> {
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icon = getIcon(
      icon: widget.icon,
      horizontalPadding: 20,
      color: Colors.black,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextField(
        controller: widget.input,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
          border: const OutlineInputBorder(
              borderSide: (BorderSide(color: Colors.black, width: 1))),
          hintText: widget.hint,
          prefixIcon: icon,
          hintStyle: kBodyTextBlack,
        ),
        style: kBodyTextBlack,
        keyboardType: widget.inputType,
        textInputAction: widget.inputAction,
      ),
    );
  }
}
