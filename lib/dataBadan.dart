class DataBadan {
  final double beratBadan, tinggiBadan, umur, kalori, hitunganKalori;
  final String jenisKelamin;

  DataBadan({
    this.beratBadan,
    this.tinggiBadan,
    this.umur,
    this.jenisKelamin,
    this.kalori,
    this.hitunganKalori,
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
    );
  }
}
