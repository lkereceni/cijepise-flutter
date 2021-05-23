import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cijepise/models/user.dart';
import 'package:flutter/foundation.dart';

class Database {
  static const ROOT = 'student.vsmti.hr';
  static const PATH = 'lkereceni/db.php';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_USER_ACTION = 'ADD_USER';
  static const _UPDATE_USER_ACTION = 'UPDATE_USER';

  static Future<List<User>> getUsers(http.Client client) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await client.post(Uri.http(ROOT, PATH), body: map);

      print(response.body);
      //return compute(parseUserInfo, response.body);

      if (response.statusCode == 200) {
        List<User> list = parseResponse(response.body);
        return list;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static List<User> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);

    return parsed.map<User>((json) => User.fromJson(json[0])).toList();
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
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_USER_ACTION;
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
}

List<User> parseUserInfo(String responseBody) {
  final parsed = json.decode(responseBody);

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}
