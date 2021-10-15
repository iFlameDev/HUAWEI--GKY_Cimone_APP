import 'package:gky_cmn/data/user_login_data.dart';
import 'package:gky_cmn/std_lib.dart';
import 'package:intl/intl.dart';

class UserData {
  String? email;
  String? name;
  String? address;
  String? phoneNumber;
  String? memberShip;
  String? gender;
  String? bloodType;
  String? placeOfBirth;
  DateTime? bod;
  bool maritalStatus = false;
  bool isVaccinated = false;

  ServiceAvailability serviceAvailability = ServiceAvailability();
  AccountLoginExternal loginData = AccountLoginExternal();

  UserData({
    this.email,
    this.name,
    this.address,
    this.phoneNumber,
    this.bod,
    this.memberShip,
    this.gender,
    this.bloodType,
    this.placeOfBirth,
  });

  GetUserDataFromJSON(dynamic json) {
    Map<String, dynamic> jsonMAP = jsonDecode(json);

    if (jsonMAP['info_jemaat'] != null) {
      jsonMAP = jsonMAP['info_jemaat'];
    }

    email = jsonMAP['email'];
    name = jsonMAP['nama'];
    address = jsonMAP['alamat'];
    phoneNumber = jsonMAP['no_hp'];
    bod = DateTime.parse(jsonMAP['tanggal_lahir']);
    memberShip = jsonMAP['no_jemaat'];
    gender = jsonMAP['jenis_kelamin'];
    bloodType = jsonMAP['golongan_darah'];
    placeOfBirth = jsonMAP['tempat_lahir'];
    isVaccinated = jsonMAP['vaksinasi'] == "1" ? true : false;
    maritalStatus = jsonMAP['status_perkawinan'] == "1" ? true : false;
  }

  String UserDataToJSON() {
    Map<String, String> jsonMAP = {
      'email': email!,
      'nama': name!,
      'alamat': address!,
      'no_hp': phoneNumber!,
      'tanggal_lahir': DateFormat('yyyy-MM-dd').format(bod!).toString(),
      'no_jemaat': memberShip!,
      'jenis_kelamin': gender!,
      'golongan_darah': bloodType!,
      'tempat_lahir': placeOfBirth!,
      'vaksinasi': isVaccinated == true ? "1" : "0",
      'status_perkawinan': maritalStatus == true ? "1" : "0",
    };

    return jsonEncode(jsonMAP);
  }

  // ================================================================================================
  // String getHMSstatusCode() {
  //   return hmsStatus.toString();
  // }

  // String getHMSstatusStatement() {
  //   switch (hmsStatus) {
  //     case 1:
  //       return 'No HMS Core (APK) is found on device.';
  //     case 2:
  //       return 'MS Core (APK) installed is out of date.';
  //     case 3:
  //       return 'HMS Core (APK) installed on the device is unavailable.';
  //     case 9:
  //       return 'HMS Core (APK) installed on the device is not the official version.';
  //     case 21:
  //       return 'The device is too old to support HMS Core (APK).';
  //     default:
  //       return 'Error Undifined <HmsApiAvailability>';
  //   }
  // }
}
