import 'package:gky_cmn/std_lib.dart';

class ServiceAvailability {
  HMScheck hms = HMScheck();

  bool? HMSavailability;
  // gms;
  // ios;

  ServiceAvailability() {
    HMSavailability = hms.isAvailable();
    // gms
    // ios
  }

  bool getHMSavailability() {
    return HMSavailability!;
  }
}
