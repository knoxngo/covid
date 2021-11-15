class CovidWorld {
  final String? totalCases;
  final String? newCases;
  final String? totalDeaths;
  final String? totalRecovered;
  final String? statisticTakenAt;

  CovidWorld({
    this.totalCases,
    this.newCases,
    this.totalDeaths,
    this.statisticTakenAt,
    this.totalRecovered,
  });
  factory CovidWorld.json(dynamic json) {
    return CovidWorld(
      newCases: json['new_cases'] as String,
      totalCases: json['total_cases'] as String,
      totalDeaths: json['total_deaths'] as String,
      totalRecovered: json['total_recovered'] as String,
      statisticTakenAt: json['statistic_taken_at'] as String,
    );
  }
  static List<CovidWorld> covidWorldFromSnapShot(List snapshot) {
    return snapshot.map((e) {
      return CovidWorld.json(e);
    }).toList();
  }

  @override
  String toString() {
    return 'Covid World {TotalCases: $totalCases, NewCases: $newCases,}';
  }
}
