import '../std_lib.dart';

class AdminDialog {
  Future<CodeStatusUUID> dialogBodyTemperature(
      CodeStatusUUID data, BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    TextEditingController bodyTemperatureController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text(
              'Selamat hari minggu, ${getFirstWord(data.name!)}',
              style: const TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Container(
              child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: bodyTemperatureController,
                    autofocus: true,
                    autocorrect: true,
                    validator: (value) => (value!.isEmpty)
                        ? 'Tidak Boleh Kosong'
                        : (!isFloat(value) ? 'Suhu Tidak Valid' : null),
                    decoration: InputDecoration(
                      // Change !!!
                      labelText: 'Suhu Tubuh',
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
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
                  )),
            ),
            actions: [
              SizedBox(
                width: 100,
                height: 60,
                child: TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print(bodyTemperatureController.text);
                        // set Temperature To Object
                        data.setBodyTemperature(bodyTemperatureController.text);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text(
                      'OK',
                      style: kBodyTextBlack,
                    )),
              ),
            ],
          ),
        );
      },
    );
    return data;
  }

  Future<void> dialogSuccess(CodeStatusUUID data, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('System'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Kamu sudah didata !!'),
                Text('Selamat beribadah ${data.name}')
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

// {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{    Get First String    }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
  String getFirstWord(String inputString) {
    List<String> wordList = inputString.split(" ");
    if (wordList.isNotEmpty) {
      return wordList[0];
    } else {
      return ' ';
    }
  }
}
