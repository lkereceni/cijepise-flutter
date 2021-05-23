class User {
  final String id;
  final String ime;
  final String prezime;
  final String adresa;
  final String grad;
  final String zupanija;
  final String oib;
  final int datumRodenja;
  final String lozinka;

  User(
      {this.id,
      this.ime,
      this.prezime,
      this.adresa,
      this.grad,
      this.zupanija,
      this.oib,
      this.datumRodenja,
      this.lozinka});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['ID'],
      ime: json['ime'],
      prezime: json['prezime'],
      adresa: json['adresa'],
      grad: json['grad'],
      zupanija: json['zupanija'],
      oib: json['OIB'],
      datumRodenja: json['datum_rodeja'],
      lozinka: json['lozinka'],
    );
  }
}
