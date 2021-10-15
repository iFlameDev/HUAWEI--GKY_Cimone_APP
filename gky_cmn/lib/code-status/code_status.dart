import 'dart:convert';

class CodeStatus {
  String? code;
  String? status;

  CodeStatus({this.code, this.status});

  getCodeStatus(dynamic json) {
    print(json);
    Map<String, dynamic> jsonMAP = jsonDecode(json);

    code = jsonMAP['kode'];
    status = jsonMAP['status'];
  }
}
