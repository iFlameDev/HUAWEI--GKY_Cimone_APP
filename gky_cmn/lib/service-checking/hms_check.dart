class HMScheck {
  bool? available;

  HMScheck() {
    // available = getAvailability() as bool?;
    available = true;
  }

  // Future<bool> getAvailability() async {
  //   int result = await HmsApiAvailability().isHMSAvailable();
  //   if (result == 0) {
  //     return true;
  //   } else
  //     return false;
  // }

  bool isAvailable() {
    return available!;
  }
}
