// import 'package:gky_cmn/register-widgets/get_icon_register.dart';

// import '../std_lib.dart';

// enum Gender { f, m }

// /// This is the stateful widget that the main application instantiates.
// class GenderRadio extends StatefulWidget {
//   const GenderRadio({Key? key}) : super(key: key);

//   @override
//   State<GenderRadio> createState() => _GenderRadioState();
// }

// /// This is the private State class that goes with GenderRadio.
// class _GenderRadioState extends State<GenderRadio> {
//   Gender? genderValue = Gender.m;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 5),
//           child: Radio<Gender>(
//             value: Gender.f,
//             groupValue: genderValue,
//             activeColor: Colors.pink,
//             onChanged: (Gender? value) {
//               setState(() {
//                 genderValue = value;
//               });
//             },
//           ),
//         ),
//         const getIcon(
//           icon: FontAwesomeIcons.female,
//           horizontalPadding: 0,
//           color: Colors.pink,
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 5),
//           child: Radio<Gender>(
//             value: Gender.m,
//             groupValue: genderValue,
//             activeColor: Colors.lightBlue,
//             onChanged: (Gender? value) {
//               setState(() {
//                 genderValue = value;
//               });
//             },
//           ),
//         ),
//         const getIcon(
//           icon: FontAwesomeIcons.male,
//           horizontalPadding: 0,
//           color: Colors.lightBlue,
//         ),
//       ],
//     );
//   }
// }
