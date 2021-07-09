import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  bool isChecked = false;
  @override
  State<CheckBox> createState() => _CheckBoxState();
}

/// This is the private State class that goes with CheckBox.
class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.red),
      child: Transform.scale(
        scale: 1.5,
        child: Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.green,
          value: widget.isChecked,
          onChanged: (bool? value) {
            setState(() {
              widget.isChecked = value!;
            });
          },
        ),
      ),
    );
  }
}
