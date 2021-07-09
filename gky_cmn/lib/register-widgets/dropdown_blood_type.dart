import 'package:flutter/material.dart';
import 'package:gky_cmn/std_lib.dart';

class dropDownBT extends StatefulWidget {
  // ignore: prefer_final_fields
  String chosenValue = 'IOS';

  String getValue() {
    return chosenValue;
  }

  @override
  _dropDownBTState createState() => _dropDownBTState();
}

class _dropDownBTState extends State<dropDownBT> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.chosenValue,
      //elevation: 5,
      style: kBodyTextBlack,

      items: <String>[
        'Android',
        'IOS',
        'Flutter',
        'Node',
        'Java',
        'Python',
        'PHP',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: const Text("Please choose a language", style: kBodyTextBlack),
      onChanged: (String? value) {
        setState(() {
          widget.chosenValue = value!;
        });
      },
    );
  }
}
