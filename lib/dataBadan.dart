class DataBadan {
  final double beratBadan, tinggiBadan, umur, kalori, hitunganKalori, imt;
  final String jenisKelamin, hari, tanggal, jam, usernameSaved, statusIMT;

  DataBadan({
    this.beratBadan,
    this.tinggiBadan,
    this.umur,
    this.jenisKelamin,
    this.kalori,
    this.hitunganKalori,
    this.imt,
    this.hari,
    this.tanggal,
    this.jam,
    this.usernameSaved,
    this.statusIMT,
  });

  factory DataBadan.fromJson(Map<dynamic, dynamic> json) {
    double parser(dynamic source) {
      try {
        return double.parse(source.toString());
      } on FormatException {
        return -1;
      }
    }

    return DataBadan(
      beratBadan: parser(json['beratBadan']),
      tinggiBadan: parser(json['tinggiBadan']),
      umur: parser(json['umur']),
      jenisKelamin: (json['jenisKelamin']),
      kalori: parser(json['kalori']),
      hitunganKalori: parser(json['hitunganKalori']),
      imt: parser(json['imt']),
      hari: (json['hari']),
      tanggal: (json['tanggal']),
      jam: (json['jam']),
      usernameSaved: (json['usernameSaved']),
      statusIMT: (json['statusIMT']),
    );
  }
}
