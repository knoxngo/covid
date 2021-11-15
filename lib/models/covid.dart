class Covid {
  final String? countryName;
  final String? deaths;
  Covid({this.countryName, this.deaths});

  factory Covid.fromJson(dynamic json) {
    return Covid(
      countryName: json['country_name'] as String,
      deaths: json['deaths'] as String,
    );
  }
  static List<Covid> covidFromSnapShot(List snapshot) {
    return snapshot.map((data) {
      return Covid.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Covid {name: $countryName, death: $deaths,}';
  }
}
