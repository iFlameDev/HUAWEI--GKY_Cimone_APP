import 'dart:io';

import 'package:flutter/cupertino.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:huawei_scan/hmsScanPermissions/HmsScanPermissions.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:huawei_scan/hmsScanUtils/DefaultViewRequest.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:huawei_scan/hmsScanUtils/HmsScanUtils.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:huawei_scan/model/ScanResponse.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:huawei_scan/utils/HmsScanTypes.dart';

import 'package:http/http.dart' as http;

import 'package:gky_cmn/std_lib.dart';

class AdminPage extends StatefulWidget {
  final UserData userData;
  const AdminPage({Key? key, required this.userData}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String resultUUID = "";
  @override
  Widget build(BuildContext context) {
    // permission for huawei scan kit
    String permissionState = "Permissions Are Not Granted.";
    bool hmsLoggerStatus = true;

// {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{    Permission    }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
    permissionRequest() async {
      bool permissionResult =
          await HmsScanPermissions.hasCameraAndStoragePermission();
      if (permissionResult == false) {
        await HmsScanPermissions.requestCameraAndStoragePermissions();
      } else {
        setState(() {
          permissionState = "All Permissions Are Granted";
        });
      }
    }

//=============================    Scan Button    ===================================
    final scan = TextButton.icon(
        onPressed: () async {
          if (kIsWeb) {
            // browser scanner
          }
          // >>>>>>>>>>>>>>>  HUAWEI Scanner  <<<<<<<<<<<<<<<<
          // Android Useable
          else if (Platform.isAndroid) {
            await permissionRequest();
            await startScanHUAWEI();
          }
        },
        icon: const getIcon(
            icon: FontAwesomeIcons.qrcode,
            horizontalPadding: 0,
            color: Colors.white),
        label: const Text(
          'Scan',
          style: kBodyText,
        ),
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid),
            )));

//============================  Download Data Profile Jemaat    ======================
    final downloadDataUser = TextButton.icon(
        onPressed: () {},
        icon: const getIcon(
            icon: FontAwesomeIcons.fileDownload,
            horizontalPadding: 0,
            color: Colors.white),
        label: const Text(
          'Download Data Jemaat',
          style: kBodyText,
        ),
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid),
            )));

//========================     Download Data Kehadiran JEMAAT      ========================
    final downloadDataIbadah = TextButton.icon(
        onPressed: () {},
        icon: const getIcon(
            icon: FontAwesomeIcons.fileDownload,
            horizontalPadding: 0,
            color: Colors.white),
        label: const Text(
          'Download Data Ibadah',
          style: kBodyText,
        ),
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid),
            )));

    // ignore: prefer_const_constructors
    final spacing = SizedBox(
      height: displayHeight(context) * 0.1,
    );

// ===================================   layout   ====================================
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hai, Admin',
          style: kHeading,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            scan,
            spacing,
            downloadDataIbadah,
            spacing,
            downloadDataUser
          ],
        ),
      ),
    );
  }

  startScanHUAWEI() async {
    DefaultViewRequest request =
        DefaultViewRequest(scanType: HmsScanTypes.AllScanType);
    ScanResponse response = await HmsScanUtils.startDefaultView(request);
    String result = response.originalValue;
    await processData(result);
  }

  processData(String result) async {
    CodeStatusUUID codeStatusUUID = CodeStatusUUID();
    codeStatusUUID = await checkUUID(result);

    if (codeStatusUUID.code == '001') {
      codeStatusUUID =
          await AdminDialog().dialogBodyTemperature(codeStatusUUID, context);
      sendTemperatureToServer(codeStatusUUID);
    } else {
      await DialogError().show(codeStatusUUID, context);
    }
  }

//{{{{{{{{{{{{{{{{{{{{{{{{    check UUID    }}}}}}}}}}}}}}}}}}}}}}}}
  Future<CodeStatusUUID> checkUUID(String uuid) async {
    var response;
    CodeStatusUUID codeStatusUUID = CodeStatusUUID();
    // HTTP Request
    try {
      response = await http.post(
        Uri.parse('${rootReservasi}cek_uuid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uuid': uuid,
        }),
      );
    } on Exception catch (e) {
      print(e);
    }

    CodeStatus codeStatus = CodeStatus();
    codeStatus.getCodeStatus(response.body);

    if (codeStatus.code == '001')
      codeStatusUUID.setValue(jsonDecode(response.body));
    else {
      codeStatusUUID.code = codeStatus.code;
      codeStatusUUID.status = codeStatus.status;
    }
    return codeStatusUUID;
  }

  sendTemperatureToServer(CodeStatusUUID data) async {
    var response;
    try {
      response = await http.post(
        Uri.parse('${rootReservasi}hadir'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()),
      );
    } on Exception catch (e) {
      print(e);
    }
    data.getCodeStatus(jsonDecode(response.body));

    if (data.code == '001') {
      await AdminDialog().dialogSuccess(data, context);
    } else if (DateTime.now().day != 7) {
      data.code = '007';
      data.status = 'Scan tidak dilakukan pada hari minggu';
      await DialogError().show(data, context);
    } else {
      await DialogError().show(data, context);
    }
  }
}
