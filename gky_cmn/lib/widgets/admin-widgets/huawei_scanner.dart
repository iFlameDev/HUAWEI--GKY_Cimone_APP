import 'package:gky_cmn/std_lib.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:huawei_scan/hmsScanUtils/DefaultViewRequest.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:huawei_scan/hmsScanUtils/HmsScanUtils.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:huawei_scan/model/ScanResponse.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:huawei_scan/utils/HmsScanTypes.dart';
import 'package:validators/validators.dart';

class HuaweiScanner extends StatefulWidget {
  HuaweiScanner({Key? key}) : super(key: key);

  @override
  _HuaweiScannerState createState() => _HuaweiScannerState();
}

class _HuaweiScannerState extends State<HuaweiScanner> {
  TextEditingController bodyTemperatureController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    startScan();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  bool checkUUID(String uuid) {
    // HTTP Request
    if (uuid != null) {
      return true;
    }
    return false;
  }

  startScan() async {
    DefaultViewRequest request =
        DefaultViewRequest(scanType: HmsScanTypes.AllScanType);
    ScanResponse response = await HmsScanUtils.startDefaultView(request);
    String result = response.originalValue;

    // Check UUID to server HHTP REQ
    if (checkUUID(result)) {
      setState(() async {
        await dialogBodyTemperature();
      });
    } else {
      setState(() async {
        await dialogUUIDInvalid();
      });
    }
  }

  sendTemperatureToServer(String temperature) {
    // HTTP ReQ

    // start scan from first process
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));
  }

  Future<void> dialogBodyTemperature() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Input Temperature'),
            content: Form(
                key: formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        // Change !!!
                        controller: bodyTemperatureController,
                        autofocus: true,
                        autocorrect: true,
                        // Change !!!
                        validator: (value) => (value!.isEmpty)
                            ? 'Tidak Boleh Kosong'
                            : (!isNumeric(value) ? 'Suhu Tidak Valid' : null),
                        decoration: InputDecoration(
                          // Change !!!
                          labelText: 'Suhu Tubuh',
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(
                              // Change !!!
                              FontAwesomeIcons.thermometerHalf,
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
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(context).pop();
                            sendTemperatureToServer(
                                bodyTemperatureController.text);
                          }
                        },
                        child: const Text('Ok'))
                  ],
                )));
      },
    );
  }

  Future<void> dialogUUIDInvalid() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('System Error : 404'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('QR Code Invalid'),
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
}
