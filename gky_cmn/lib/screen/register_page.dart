// @dart=2.9
import 'package:gky_cmn/screen/home_page.dart';

import '../std_lib.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import '../register-widgets/export_register_widgets.dart';
import 'package:validators/validators.dart';

// ignore: use_key_in_widget_constructors
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
// Input Controller =================================================
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // TextEditingController gkyMembership = TextEditingController();

// Input Value ===========================================================
  String nameValue;
  String addressValue;
  String phoneValue;
  DateTime bodValue;
  String genderValue = 'm';
  bool isVaccinated = false;
  String btValue;

// Form Key
  final formKey = GlobalKey<FormState>();

// Widget Build ===============================================================
  @override
  Widget build(BuildContext context) {
// Constructing widget ==============================================

//=================================== Name Input ===========================
    final name = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        // Change !!!
        controller: nameController,
        autofocus: true,
        autocorrect: true,
        // Change !!!
        validator: (value) => isEmpty(value),
        decoration: InputDecoration(
          // Change !!!
          labelText: 'Name',
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          focusColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              // Change !!!
              FontAwesomeIcons.userAlt,
              color: Colors.black,
              size: 30,
            ),
          ),
          hintStyle: kBodyTextBlack,
        ),
        // Change !!!
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      ),
    );
// ========================================= Phone Input ===============================
    final phone = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        // Change !!!
        controller: phoneController,
        autofocus: true,
        autocorrect: true,
        // Change !!!
        validator: (value) => (value.isEmpty)
            ? 'Cannot Empty'
            : (!isNumeric(value) ? 'Invalid Phone Number' : null),
        decoration: InputDecoration(
          // Change !!!
          labelText: 'Phone',
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          focusColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              // Change !!!
              FontAwesomeIcons.phone,
              color: Colors.black,
              size: 30,
            ),
          ),
          hintStyle: kBodyTextBlack,
        ),
        // Change !!!
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
      ),
    );

// ======================================== Address Input ================================
    final address = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        // Change !!!
        controller: addressController,
        autofocus: true,
        autocorrect: true,
        // Change !!!
        validator: (value) => isEmpty(value.toString()),
        decoration: InputDecoration(
          // Change !!!
          labelText: 'Address',
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          focusColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              // Change !!!
              FontAwesomeIcons.mapMarkerAlt,
              color: Colors.black,
              size: 30,
            ),
          ),
          hintStyle: kBodyTextBlack,
        ),
        // Change !!!
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      ),
    );

// ============================================= Birthday Input =======================================
    final bod = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: DateTimeField(
        format: DateFormat('dd MMMM yyyy'),
        validator: (date) {
          if (date == null) {
            bodValue = date;
            return 'Cannot Empty';
          } else {
            bodValue = date;
            return null;
          }
        },
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        decoration: InputDecoration(
          // Change !!!
          labelText: 'Birth Day',
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          focusColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              // Change !!!
              FontAwesomeIcons.calendarDay,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        textInputAction: TextInputAction.next,
      ),
    );

// ================================================== Blood Type Input ===============================================
    final bloodType = Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: DropdownButtonFormField<String>(
          isExpanded: true,
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
          onChanged: (String value) {
            setState(() {
              btValue = value;
            });
          },
          validator: (String value) => isEmpty(value),
          decoration: InputDecoration(
            // Change !!!
            labelText: 'Blood Type',
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            focusColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                // Change !!!
                FontAwesomeIcons.tint,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ));

// ================================================== Gender Input ===============================================

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Radio<String>(
                value: 'm',
                groupValue: genderValue,
                activeColor: Colors.lightBlue,
                onChanged: (String value) {
                  setState(() {
                    genderValue = value;
                  });
                },
              ),
            ),
            const getIcon(
              icon: FontAwesomeIcons.male,
              horizontalPadding: 0,
              color: Colors.lightBlue,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Radio<String>(
                value: 'f',
                groupValue: genderValue,
                activeColor: Colors.pink,
                onChanged: (String value) {
                  setState(() {
                    genderValue = value;
                  });
                },
              ),
            ),
            const getIcon(
              icon: FontAwesomeIcons.female,
              horizontalPadding: 0,
              color: Colors.pink,
            ),
          ],
        ),
      ],
    );

// // ================================================== Vacinated Input ===============================================
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
        Theme(
          data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.red),
          child: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.green,
              value: isVaccinated,
              onChanged: (bool value) {
                setState(() {
                  isVaccinated = value;
                });
              },
            ),
          ),
        ),
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
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          children: [
            name,
            address,
            phone,
            bod,
            bloodType,
            gender,
            separator,
            vacinnated,
            const SizedBox(
              height: 20,
            ),
            submitBtn
          ],
        ),
      ),
    );
  }

  String isEmpty(String val) {
    return val == null || val.isEmpty ? "Cannot Empty" : null;
  }

  void submit() => {
        if (formKey.currentState.validate())
          {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Processing Data')))
          },
        nameValue = nameController.text,
        addressValue = addressController.text,
        phoneValue = phoneController.text,

        // HTTP REQUEST HTTP RESPONSE

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            ModalRoute.withName('/loginPage'))
      };
}
