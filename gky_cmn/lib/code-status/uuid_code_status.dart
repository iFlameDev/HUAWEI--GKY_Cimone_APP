import './code_status.dart';

class CodeStatusUUID extends CodeStatus {
  String? uuid;
  String? name;
  double? bodyTemperature;

  CodeStatusUUID({String? codeS, String? statusS}) {
    code = codeS;
    status = statusS;
  }

  setValue(Map<String, dynamic> json) {
    getCodeStatus(json);
    try {
      uuid = json['detail']['uuid'];
      name = json['detail']['nama'];
    } on Exception catch (e) {
      print(e);
    }
  }

  Map<String, Object> toJson() =>
      {'uuid': uuid!, 'suhu_badan': bodyTemperature!};

  setBodyTemperature(String value) {
    bodyTemperature = double.parse(value);
  }
}
