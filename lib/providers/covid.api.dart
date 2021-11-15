import 'dart:convert';
import '../models/covid.dart';
import '../models/covid_world.dart';

import 'package:http/http.dart' as http;

class CovidApi {
  static Future<List<Covid>> getCovid() async {
    var uri =
        Uri.https('corona-virus-world-and-india-data.p.rapidapi.com', '/api');
    final response = await http.get(uri, headers: {
      "x-rapidapi-host": "corona-virus-world-and-india-data.p.rapidapi.com",
      "x-rapidapi-key": "9c51951073msh41ece6840b93ce7p12ba80jsn8c83755ee23a",
      "useQueryString": 'true'
    });

    Map data = jsonDecode(response.body);
    List _temp = [];
    for (var i in data['countries_stat']) {
      _temp.add(i);
    }
    return Covid.covidFromSnapShot(_temp);
  }

  static Future<List<CovidWorld>> getCovidWorld() async {
    var uri =
        Uri.https('corona-virus-world-and-india-data.p.rapidapi.com', '/api');
    final response = await http.get(uri, headers: {
      "x-rapidapi-host": "corona-virus-world-and-india-data.p.rapidapi.com",
      "x-rapidapi-key": "9c51951073msh41ece6840b93ce7p12ba80jsn8c83755ee23a",
      "useQueryString": 'true'
    });

    Map data = jsonDecode(response.body);

    List _tempWorld = [];

    _tempWorld.add(data['world_total']);
    // print(_tempWorld);
    return CovidWorld.covidWorldFromSnapShot(_tempWorld);
  }
}
