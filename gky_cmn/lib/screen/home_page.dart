import 'package:http/http.dart' as http;

// ignore: import_of_legacy_library_into_null_safe
import 'package:gky_cmn/screen/edit_user_profile.dart';

import 'package:gky_cmn/std_lib.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.userData}) : super(key: key);
  final UserData userData;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Cookies().saveLoginCookies(widget.userData);
  }

  String uuid = '';
  CodeStatus codeStatus = CodeStatus();
  InfoReservation infoIbadah = InfoReservation();

//=========================  Booking Ibadah Widget  =========================
  Widget bookingIbadah(BuildContext context) {
    return TextButton.icon(
        onPressed: () async {
          await qrRequest();
          // print('CONSOLE BOOKING IBADAH');
          // print(codeStatus.code);
          // print(codeStatus.status);
          // Reservation Close in sunday and the time is under 12 AM
          print('QR REQUEST DONE');
          print(DateTime.now().weekday);
          if (DateTime.now().weekday == 7 && codeStatus.code == '002') {
            codeStatus.code = '000';
            codeStatus.status =
                'Sistem reservasi sedang tutup, mohon melakukan reservasi dihari SENIN';
            DialogError().show(codeStatus, context);
          }
          // not Booked yet
          else if (codeStatus.code == '002') {
            await getInfoIbadah();
            await dialogInfoIbadah();
            await dialogSuccessReservation();
          }
          // already booked
          else if (codeStatus.code == '001') {
            await qrDialog();
          }
        },
        icon: const getIcon(
            icon: FontAwesomeIcons.solidCalendarCheck,
            horizontalPadding: 0,
            color: Colors.black),
        label: const Text(
          'Daftar Ibadah Onsite',
          style: kBodyTextBlack,
        ));
  }

//================================  Log Out Widget   ================================
  Widget logOut(BuildContext context) {
    return TextButton.icon(
        onPressed: () async {
          Cookies().removeLoginCookies();
          Navigators().toLoginPage(context);
        },
        icon: const getIcon(
            icon: FontAwesomeIcons.signOutAlt,
            horizontalPadding: 0,
            color: Colors.black),
        label: const Text(
          'sign out',
          style: kBodyTextBlack,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final userName = widget.userData.name;

    final updateProfile = TextButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditUserProfile(
                        UserdataBefore: widget.userData,
                      )));
        },
        icon: const getIcon(
            icon: FontAwesomeIcons.userEdit,
            horizontalPadding: 5,
            color: Colors.black),
        label: const Text(
          'Ubah Data Diri',
          style: kBodyTextBlack,
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hi, ' + userName!,
          style: kHeading,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bookingIbadah(context),
            SizedBox(
              height: displayHeight(context) * 0.1,
            ),
            updateProfile,
            SizedBox(
              height: displayHeight(context) * 0.1,
            ),
            logOut(context)
          ],
        ),
      ),
    );
  }

//{{{{{{{{{{{{{{{{{{{{{{{{{{{{{    QR Request    }}}}}}}}}}}}}}}}}}}}}}}}}}}}}
  Future<void> qrRequest() async {
    var response;
    try {
      response = await http.post(
        Uri.parse('${rootReservasi}cek'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': widget.userData.email!,
        }),
      );
    } on Exception catch (e) {
      print(e);
    }
    // get Code Status
    codeStatus.getCodeStatus(response.body);
    if (codeStatus.code == '001') {
      print('MASUK CHECK 001');
      print(jsonDecode(response.body)['detail']['uuid']);
      uuid = jsonDecode(response.body)['detail']['uuid'];
    } else {
      print(codeStatus.code);
      print(codeStatus.status);
    }
  }

//{{{{{{{{{{{{{{{{{{{{{{{{    Booking Ibadah Request    }}}}}}}}}}}}}}}}}}}}}}}}
  Future<void> bookingIbadahRequest() async {
    var response;
    try {
      response = await http.post(
        Uri.parse('${rootReservasi}daftar'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': widget.userData.email!,
          'waktu_ibadah': getSunday(infoIbadah.nextIbadah!)
        }),
      );
    } on Exception catch (e) {
      print(e);
    }

    // print('CONSOLE BOOKING REQUEST');
    // print(getSunday(infoIbadah.nextIbadah!));
    // print(response.statusCode);

    // get Code Status
    codeStatus.getCodeStatus(response.body);

    if (codeStatus.code == '001') {
      uuid = jsonDecode(response.body)['uuid'];
    } else {
      DialogError().show(codeStatus, context);
    }
  }

// {{{{{{{{{{{{{{{{{{{{{{{{    Get Date Time Sunday    }}}}}}}}}}}}}}}}}}}}}}}}}
  String getSunday(String date) {
    return date + " 08:00:00";
  }

//{{{{{{{{{{{{{{{{{{{{{{{{{     Get Info Ibadah     }}}}}}}}}}}}}}}}}}}}}}}}}
  Future<void> getInfoIbadah() async {
    var response;
    try {
      response = await http.get(Uri.parse('${rootReservasi}info'));
    } on Exception catch (e) {
      print(e);
    }

    try {
      codeStatus.getCodeStatus(response.body);
    } catch (e) {
      print(e);
    }

    if (codeStatus != '999') {
      infoIbadah.fetchJsonGetInfoReservation(jsonDecode(response.body));
    }
  }

//[[[[[[[[[[[[[[[[[[[[[[[[[[    DIALOG INFO IBADAH    ]]]]]]]]]]]]]]]]]]]]]]]]]]
  Future<void> dialogInfoIbadah() async => showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Info Reservasi'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Kapasitas Maximum: ${infoIbadah.max}"),
                  Text("Tanggal Sekarang : ${infoIbadah.today}"),
                  Text("Tanggal Ibadah   : ${infoIbadah.nextIbadah}"),
                  Text("Banyak Reservasi : ${infoIbadah.totalReservation}"),
                  Text("Sisa Tempat      : ${infoIbadah.availableSeats}"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Reservasi'),
                onPressed: () {
                  Navigator.of(context).pop();
                  bookingIbadahRequest();
                },
              ),
              TextButton(
                child: const Text('Batal'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                },
              ),
            ],
          );
        },
      );

// [[[[[[[[[[[[[[[[[[[[[[[[[[    QR DIALOG    ]]]]]]]]]]]]]]]]]]]]]]]]]]
  // ignore: non_constant_identifier_names
  Future<void> qrDialog() async => showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('SCAN ME !!!'),
            content: Container(
                width: displayWidth(context) * 0.6,
                height: displayWidth(context) * 0.6,
                child: QrImage(data: uuid, size: displayWidth(context) * 0.6)),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

//[[[[[[[[[[[[[[[[[[[[[[[[[[[     Success Dialog     ]]]]]]]]]]]]]]]]]]]]]]]]]]]
  Future<void> dialogSuccessReservation() async => showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('System'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Berhasil mendaftar !'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
}
