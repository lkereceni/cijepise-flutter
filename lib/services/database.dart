import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

//Models
import 'package:cijepise/models/user.dart';
import 'package:cijepise/models/zupanija.dart';

class Database {
  static const ROOT = 'student.vsmti.hr';
  static const PATH = 'lkereceni/db.php';
  static const _GET_USER_ACTION = 'GET_USER';
  static const _ADD_USER_ACTION = 'ADD_USER';
  static const _UPDATE_USER_ACTION = 'UPDATE_USER';
  static const _GET_ZUPANIJE_ACTION = 'GET_ZUPANIJE';
  static const _GET_OIB_ACTION = 'GET_OIB';

  static Future<List<User>> getUsers(http.Client client, String oib) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_USER_ACTION;
      map['OIB'] = oib;
      final response = await client.post(Uri.http(ROOT, PATH), body: map);

      if (response.statusCode == 200) {
        List<User> list = parseUser(response.body);
        return list;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static List<User> parseUser(String responseBody) {
    final parsed = json.decode(responseBody);

    return parsed[0].map<User>((json) => User.fromJson(json[0])).toList();
  }

  static Future<String> addUser(
    String ime,
    String prezime,
    String adresa,
    String grad,
    String zupanija,
    int oib,
    int datumRodenja,
    String lozinka,
  ) async {
    print(
        'Ime: $ime, Prezime: $prezime, Adresa: $adresa, Grad: $grad, Zupanija: $zupanija, OIB: $oib, DatumRodenja: $datumRodenja, Lozinka: $lozinka');
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_USER_ACTION;
      map['ime'] = ime;
      map['prezime'] = prezime;
      map['adresa'] = adresa;
      map['grad'] = grad;
      map['zupanija'] = zupanija;
      map['OIB'] = oib.toString();
      map['datum_rodenja'] = datumRodenja.toString();
      map['lozinka'] = lozinka;

      final response = await http.post(Uri.http(ROOT, PATH), body: map);

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<String> updateUser(
    int id,
    String ime,
    String prezime,
    String adresa,
    String grad,
    String zupanija,
    int oib,
    int datumRodenja,
    String lozinka,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_USER_ACTION;
      map['id'] = id;
      map['ime'] = ime;
      map['prezime'] = prezime;
      map['adresa'] = adresa;
      map['grad'] = grad;
      map['zupanija'] = zupanija;
      map['OIB'] = oib;
      map['datum_rodenja'] = datumRodenja;
      map['lozinka'] = lozinka;

      final response = await http.post(Uri.http(ROOT, PATH), body: map);

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Zupanija>> getZupanije(http.Client client) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ZUPANIJE_ACTION;
      final response = await client.post(Uri.http(ROOT, PATH), body: map);

      if (response.statusCode == 200) {
        List<Zupanija> list = parseZupanije(response.body);
        return list;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static List<Zupanija> parseZupanije(String responseBody) {
    final parsed = json.decode(responseBody);

    return parsed[0].map<Zupanija>((json) => Zupanija.fromJson(json)).toList();
  }

  static Future<void> gradoviJson(String query) async {
    if (query == null || query == '') {
      return null;
    } else {
      final String response = await rootBundle.loadString('lib/data/gradovi.json');
      final data = await json.decode(response);
      List gradovi = [];

      gradovi = data.where((elem) => elem['zupanija'].toString().contains(query)).toList();

      return gradovi;
    }
  }

  static Future<List> getOIB(http.Client client) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_OIB_ACTION;
      final response = await client.post(Uri.http(ROOT, PATH), body: map);

      if (response.statusCode == 200) {
        List oib = [];
        List<User> list = parseOIB(response.body);

        for (int i = 0; i < list.length; i++) {
          oib.add(list[i].oib);
        }

        return oib;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static List<void> parseOIB(String responseBody) {
    final parsed = json.decode(responseBody);

    return parsed[0].map<User>((json) => User.fromJson(json)).toList();
  }
}
