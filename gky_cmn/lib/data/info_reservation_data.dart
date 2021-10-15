class InfoReservation {
  int? max;
  String? today;
  String? nextIbadah;
  int? totalReservation;
  int? availableSeats;

  InfoReservation(
      {this.max,
      this.today,
      this.nextIbadah,
      this.totalReservation,
      this.availableSeats});

  fetchJsonGetInfoReservation(Map<String, dynamic> json) {
    print('CONSOLE FETCH INFORESERVATION');
    print(json['maximum_tempat']);
    max = json['maximum_tempat'];
    today = json['tanggal_sekarang'];
    nextIbadah = json['ibadah_selanjutnya'];
    totalReservation = json['jumlah_reservasi'];
    availableSeats = json['sisa_tempat'];
  }
}
