import 'package:gky_cmn/register-widgets/dropdown_blood_type.dart';
import 'package:gky_cmn/register-widgets/submit_button.dart';

import '../std_lib.dart';
import '../register-widgets/export_register_widgets.dart';

// ignore: use_key_in_widget_constructors
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

// sudah vaksin atau blm, gol darah
enum Gender { m, f }

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    //============================== constructing widget =======================

    final name = TextInput(
      icon: FontAwesomeIcons.userAlt,
      hint: 'Name',
      inputType: TextInputType.name,
      inputAction: TextInputAction.next,
    );

    final bod = TextInput(
      icon: FontAwesomeIcons.calendarDay,
      hint: 'Birth Day',
      inputType: TextInputType.datetime,
      inputAction: TextInputAction.next,
    );

    final phone = TextInput(
      icon: FontAwesomeIcons.phone,
      hint: 'Phone',
      inputType: TextInputType.phone,
      inputAction: TextInputAction.next,
    );

    final address = TextInput(
      icon: FontAwesomeIcons.mapMarkerAlt,
      hint: 'Address',
      inputType: TextInputType.streetAddress,
      inputAction: TextInputAction.next,
    );

    // final bloodType =

    final gender = Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        // ignore: prefer_const_constructors
        getIcon(
          icon: FontAwesomeIcons.venusMars,
          horizontalPadding: 20,
          color: Colors.black,
        ),
        const Text('Gender', style: kBodyTextBlack),
        const SizedBox(
          width: 20,
        ),
        const GenderRadio(),
      ],
    );

    final vacinnated = Row(
      children: [
        // ignore: prefer_const_constructors
        getIcon(
            icon: FontAwesomeIcons.syringe,
            horizontalPadding: 20,
            color: Colors.black),
        const Text(
          'Have you been vaccinated?',
          style: kBodyTextBlack,
        ),
        const SizedBox(width: 10),
        CheckBox(),
      ],
    );

    // ignore: prefer_const_constructors
    final separator = Divider(
      color: Colors.black,
      thickness: 2,
    );

    final submitBtn =
        SubmitButton(buttonText: 'Submit', onclick: () => submit());

    //===================================== Layout ================================
    return Scaffold(
      appBar:
          AppBar(title: const Text('Registration'), titleTextStyle: kHeading),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          name,
          address,
          bod,
          phone,
          dropDownBT(),
          gender,
          // =========
          separator,
          // =========
          vacinnated,
          const SizedBox(
            height: 20,
          ),
          submitBtn
        ],
      ),
    );
  }

  submit() => {print('asdsadsa')};
}
