// @dart=2.9

import 'package:gky_cmn/dialog-box/@export_dialog_box.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../std_lib.dart';

// ignore: use_key_in_widget_constructors
class RegisterPage extends StatefulWidget {
  UserData userData;

  RegisterPage({Key key, this.userData}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  Input Controller  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController gkyMembershipController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  Form Key  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  final formKey = GlobalKey<FormState>();

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  Widget Build  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  @override
  Widget build(BuildContext context) {
//    <<<<<<<<<<<<<<<<<<<<<<<<<  Constructing widget  >>>>>>>>>>>>>>>>>>>>>>>>>

// ====================================  GKY Membership  ============================
    final gkyMemberShip = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        // Change !!!
        controller: gkyMembershipController,
        autofocus: true,
        autocorrect: true,
        // Change !!!
        validator: (value) => isEmpty(value),
        decoration: InputDecoration(
          // Change !!!
          labelText: 'Nomor Anggota GKY',
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          focusColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              // Change !!!
              FontAwesomeIcons.idCard,
              color: Colors.black,
              size: 30,
            ),
          ),
          hintStyle: kBodyTextBlack,
        ),
        // Change !!!
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
      ),
    );

//===================================  Name Input  ===========================
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
          labelText: 'Nama',
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

// =========================================  Phone Input  ===============================
    final phone = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        // Change !!!
        controller: phoneController,
        autofocus: true,
        autocorrect: true,
        // Change !!!
        validator: (value) => (value.isEmpty)
            ? 'Tidak Boleh Kosong'
            : (!isNumeric(value) ? 'Nomor Hp Tidak Valid' : null),
        decoration: InputDecoration(
          // Change !!!
          labelText: 'No. Telp / WA',
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

// ========================================  Address Input  ================================
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
          labelText: 'Tempat Tinggal Sekarang',
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

// ===========================================  Place of Birth Input  =======================================
    final placeOfBirth = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        // Change !!!
        controller: placeOfBirthController,
        autofocus: true,
        autocorrect: true,
        // Change !!!
        validator: (value) => isEmpty(value.toString()),
        decoration: InputDecoration(
          // Change !!!
          labelText: 'Tempat Lahir',
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          focusColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              // Change !!!
              FontAwesomeIcons.mapMarkedAlt,
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

// =============================================  Birthday Input  =======================================
    final bod = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: DateTimeField(
        format: DateFormat('dd MMMM yyyy'),
        validator: (date) {
          if (date == null) {
            widget.userData.bod = date;
            return 'Cannot Empty';
          } else {
            widget.userData.bod = date;
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
          labelText: 'Tanggal Lahir',
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

// ==================================================  Blood Type Input  ===============================================
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
              widget.userData.bloodType = value;
            });
          },
          validator: (String value) => isEmpty(value),
          decoration: InputDecoration(
            // Change !!!
            labelText: 'Golongan Darah',
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

// ==================================================  Gender Input  ===============================================
    final gender = Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        // ignore: prefer_const_constructors
        getIcon(
          icon: FontAwesomeIcons.venusMars,
          horizontalPadding: 20,
          color: Colors.black,
        ),
        const Text('Jenis Kelamin', style: kBodyTextBlack),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: Radio<String>(
                    value: 'm',
                    groupValue: widget.userData.gender,
                    activeColor: Colors.lightBlue,
                    onChanged: (String value) {
                      setState(() {
                        widget.userData.gender = value;
                      });
                    },
                  ),
                ),
                const getIcon(
                  icon: FontAwesomeIcons.male,
                  horizontalPadding: 0,
                  color: Colors.lightBlue,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: Radio<String>(
                    value: 'f',
                    groupValue: widget.userData.gender,
                    activeColor: Colors.pink,
                    onChanged: (String value) {
                      setState(() {
                        widget.userData.gender = value;
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
        ),
      ],
    );

// ==================================================  Marital Status  ====================================================
    final maritalStatus = Row(
      children: [
        // ignore: prefer_const_constructors
        getIcon(
            icon: FontAwesomeIcons.ring,
            horizontalPadding: 20,
            color: Colors.black),
        const Text(
          'Status Menikah',
          style: kBodyTextBlack,
        ),
        SizedBox(width: displayWidth(context) - 282),
        Theme(
          data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.red),
          child: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.green,
              value: widget.userData.maritalStatus,
              onChanged: (bool value) {
                setState(() {
                  widget.userData.maritalStatus = value;
                });
              },
            ),
          ),
        ),
      ],
    );

// ==================================================  Vacinated Input  ===============================================
    final vacinnated = Row(
      children: [
        // ignore: prefer_const_constructors
        getIcon(
            icon: FontAwesomeIcons.syringe,
            horizontalPadding: 20,
            color: Colors.black),
        const Text(
          'Pernah vaksin Covid-19?',
          style: kBodyTextBlack,
        ),
        SizedBox(width: displayWidth(context) - 341),
        Theme(
          data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.red),
          child: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.green,
              value: widget.userData.isVaccinated,
              onChanged: (bool value) {
                setState(() {
                  widget.userData.isVaccinated = value;
                });
              },
            ),
          ),
        ),
      ],
    );

// ====================================================  Divider  ==================================================
    // ignore: prefer_const_constructors
    final separator = Divider(
      color: Colors.black,
      thickness: 2,
    );

// ==================================================  Submit Button ==================================================
    final submitBtn =
        SubmitButton(buttonText: 'Daftar', onclick: () => submit());

    //===================================== Layout ================================
    return Scaffold(
      appBar: AppBar(title: const Text('Registrasi'), titleTextStyle: kHeading),
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          children: [
            gkyMemberShip,
            name,
            address,
            phone,
            placeOfBirth,
            bod,
            bloodType,
            gender,
            separator,
            maritalStatus,
            separator,
            vacinnated,
            separator,
            const SizedBox(
              height: 20,
            ),
            submitBtn
          ],
        ),
      ),
    );
  }

// {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{   VALIDATOR   }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
  String isEmpty(String val) {
    return val == null || val.isEmpty ? "Tidak Boleh Kosong" : null;
  }

// {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{     SUBMISSION     }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
  // Temp userData
  UserData userData = UserData();
  // Temp codeStatus
  CodeStatus codeStatus = CodeStatus();
  void submit() async {
    if (formKey.currentState.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Processing Data')));
      widget.userData.name = nameController.text;
      widget.userData.address = addressController.text;
      widget.userData.phoneNumber = phoneController.text;
      widget.userData.memberShip = gkyMembershipController.text;
      widget.userData.placeOfBirth = placeOfBirthController.text;
      userData = widget.userData;

      // print('CONSOLE');
      // print(userData.gender);
      // print(userData.isVaccinated);
      // print(userData.email);
      // print(userData.name);

      // HTTP REQUEST HTTP RESPONSE
      codeStatus = await registerRequest(userData);

      if (codeStatus.code == '001') {
        Navigators().toHomePage(userData, context);
      } else {
        DialogError().show(codeStatus, context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      }
    }
  }

  // \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\   HTTP Request   ////////////////////////////////
  // Temp response
  var response;
  Future<CodeStatus> registerRequest(UserData userData) async {
    try {
      response = await http.post(
        Uri.parse('${rootJemaat}daftar'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: userData.UserDataToJSON(),
      );
    } on Exception catch (e) {
      print(e);
    }
    // get Code Status
    codeStatus.getCodeStatus(response.body);
    return codeStatus;
  }
}
