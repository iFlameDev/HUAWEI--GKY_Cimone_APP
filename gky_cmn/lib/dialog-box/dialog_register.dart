import 'package:gky_cmn/std_lib.dart';

class DialogRegister {
  Future<void> show(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('System'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Error: Email Tidak Ditemukan'),
                Text('Sepertinya kamu belum terdaftar'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Mendaftar'),
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
