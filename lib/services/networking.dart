import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

//Models
import 'package:cijepise/models/covid_info.dart';

var apiUrl = 'api.covid19api.com';
var unencodedPath = 'live/country/croatia';

List<CovidInfo> parseCovidInfo(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<CovidInfo>((json) => CovidInfo.fromJson(json)).toList();
}

Future<List<CovidInfo>> fetchCovidInfo(http.Client client) async {
  final response = await client.get(Uri.https(apiUrl, unencodedPath));
  //print(response.body);

  return compute(parseCovidInfo, response.body);
}
