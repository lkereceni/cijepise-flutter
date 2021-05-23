class CovidInfo {
  final int confirmed;
  final int deaths;
  final String date;

  CovidInfo({this.confirmed, this.deaths, this.date});

  factory CovidInfo.fromJson(Map<String, dynamic> json) {
    return CovidInfo(
      confirmed: json['Confirmed'],
      deaths: json['Deaths'],
    );
  }
}
