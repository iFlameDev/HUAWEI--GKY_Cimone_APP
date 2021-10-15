import 'package:flutter/material.dart';
import 'package:gky_cmn/std_lib.dart';

// ignore: must_be_immutable
class dropDownBT extends StatefulWidget {
  // ignore: prefer_final_fields
  String chosenValue = 'A';

  String getValue() {
    return chosenValue;
  }

  @override
  _dropDownBTState createState() => _dropDownBTState();
}

class _dropDownBTState extends State<dropDownBT> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: widget.chosenValue,
        style: kBodyTextBlack,
        items: <String>[
          'A',
          'B',
          'AB',
          'O',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: kBodyTextBlack,
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            widget.chosenValue = value!;
          });
        },
      ),
    );
  }
}
