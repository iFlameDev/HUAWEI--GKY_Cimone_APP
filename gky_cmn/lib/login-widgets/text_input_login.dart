// import 'package:flutter/material.dart';

// import '../font.dart';

// class TextInput extends StatefulWidget {
//   // ignore: use_key_in_widget_constructors
//   TextInput({
//     required this.icon,
//     required this.hint,
//     required this.inputType,
//     required this.inputAction,
//   });

//   final IconData icon;
//   final String hint;
//   final TextInputType inputType;
//   final TextInputAction inputAction;
//   final input = TextEditingController();

//   @override
//   State<TextInput> createState() => _TextInputState();

//   String getInput() {
//     return input.text;
//   }
// }

// class _TextInputState extends State<TextInput> {
//   @override
//   void dispose() {
//     // Clean up the controller when the widget is disposed.
//     widget.input.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[600]!.withOpacity(0.5),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: TextField(
//           controller: widget.input,
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.symmetric(vertical: 20),
//             border: InputBorder.none,
//             hintText: widget.hint,
//             prefixIcon: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Icon(
//                 widget.icon,
//                 color: Colors.white,
//                 size: 30,
//               ),
//             ),
//             hintStyle: kBodyText,
//           ),
//           style: kBodyText,
//           keyboardType: widget.inputType,
//           textInputAction: widget.inputAction,
//         ),
//       ),
//     );
//   }
// }

// ============================= SUSPEND