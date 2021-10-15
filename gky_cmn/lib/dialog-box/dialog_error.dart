import 'package:gky_cmn/std_lib.dart';

class DialogError {
  Future<void> show(CodeStatus codeStatus, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('System'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Error ${codeStatus.code} : ${codeStatus.status}"),
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
