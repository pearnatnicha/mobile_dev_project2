import 'dart:developer';

import 'package:firebase_demo/services/weather_model.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class ApiService {
  Future<List<WeatherModel>?> getWeather() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<WeatherModel> _model = weatherModelFromJson(response.body) as List<WeatherModel>;
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}