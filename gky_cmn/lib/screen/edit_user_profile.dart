// @dart=2.9
import 'package:gky_cmn/std_lib.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class EditUserProfile extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final UserData UserdataBefore;

  // ignore: non_constant_identifier_names
  const EditUserProfile({key, this.UserdataBefore}) : super(key: key);

  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  // User data declare =================================================
  UserData upData = UserData();

// Input Controller =================================================
  TextEditingController nameController;
  TextEditingController addressController;
  TextEditingController phoneController;
  TextEditingController gkyMembershipController;
  TextEditingController placeOfBirthController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Assign userDataBefore to value
    upData = widget.UserdataBefore;
    // <<<<<<<<<<<<<<<<<<<<<<<<<<<    initValue TextController    >>>>>>>>>>>>>>>>>>>>>>>>>>>
    nameController = TextEditingController(text: upData.name);
    addressController = TextEditingController(text: upData.address);
    phoneController = TextEditingController(text: upData.phoneNumber);
    gkyMembershipController = TextEditingController(text: upData.memberShip);
    placeOfBirthController = TextEditingController(text: upData.placeOfBirth);
  }

// Form Key
  final formKey = GlobalKey<FormState>();

// Widget Build ===============================================================
  @override
  Widget build(BuildContext context) {
    // print(upData.email);
    // print(upData.name);
    // print(upData.address);
    // print(upData.bloodType);
    // print(upData.bod);
    // print(upData.gender);
    // print(upData.isVaccinated);
    // print(upData.maritalStatus);
    // print(upData.memberShip);
    // print(upData.phoneNumber);
    // print(upData.placeOfBirth);

//============================== Constructing widget ==============================================

// ==================================== GKY Membership ============================
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

// =========================================== Place of Birth Input =======================================
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

// ============================================= Birthday Input =======================================
    final bod = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: DateTimeField(
        initialValue: upData.bod,
        format: DateFormat('dd MMMM yyyy'),
        validator: (date) {
          if (date == null) {
            upData.bod = date;
            return 'Cannot Empty';
          } else {
            upData.bod = date;
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

// ================================================== Blood Type Input ===============================================
    final bloodType = Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: DropdownButtonFormField<String>(
          value: upData.bloodType,
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
              upData.bloodType = value;
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
        const Text('Jenis Kelamin', style: kBodyTextBlack),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Radio<String>(
                    value: 'm',
                    groupValue: upData.gender,
                    activeColor: Colors.lightBlue,
                    onChanged: (String value) {
                      setState(() {
                        upData.gender = value;
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
                  padding: EdgeInsets.only(left: 5),
                  child: Radio<String>(
                    value: 'f',
                    groupValue: upData.gender,
                    activeColor: Colors.pink,
                    onChanged: (String value) {
                      setState(() {
                        upData.gender = value;
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

// ================================================== Marital Status ====================================================

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
              value: upData.maritalStatus,
              onChanged: (bool value) {
                setState(() {
                  upData.maritalStatus = value;
                });
              },
            ),
          ),
        ),
      ],
    );

// ================================================== Vacinated Input ===============================================
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
              value: upData.isVaccinated,
              onChanged: (bool value) {
                setState(() {
                  upData.isVaccinated = value;
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

    final submitBtn = SubmitButton(buttonText: 'Ubah', onclick: () => submit());

//===================================== Layout ================================
    return Scaffold(
      appBar:
          AppBar(title: const Text('Ubah Data Diri'), titleTextStyle: kHeading),
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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

  String isEmpty(String val) {
    return val == null || val.isEmpty ? "Cannot Empty" : null;
  }

  void submit() async {
    if (formKey.currentState.validate()) {
      // Asign Value to upData
      upData.name = nameController.text;
      upData.address = addressController.text;
      upData.phoneNumber = phoneController.text;
      upData.memberShip = gkyMembershipController.text;
      upData.placeOfBirth = placeOfBirthController.text;

      // HTTP REQUEST HTTP RESPONSE
      await sendDataToServer(upData);

      Navigators().toHomePage(upData, context);
    }
  }

  Future<void> sendDataToServer(UserData userData) async {
    var response;
    CodeStatus codeStatus = CodeStatus();
    try {
      response = await http.post(
        Uri.parse('${rootJemaat}edit'),
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

    if (codeStatus.code == '001') {
      await DialogSuccess().show(codeStatus, context);
    } else {
      await DialogError().show(codeStatus, context);
    }
    return;
  }
}
