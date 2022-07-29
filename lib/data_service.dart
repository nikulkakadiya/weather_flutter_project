import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models.dart';

class DetaService{
  // https://api.openweathermap.org/data/2.5/weather?q=surat&appid=b1014e87f26fd77af6d675fffc791d9b&units=metric

  Future<WeatherResponse> getWeather(String city) async {
    final queryPeramiter={'q':city,'appid':'b1014e87f26fd77af6d675fffc791d9b','units':'metric'};

    final uri=Uri.http('api.openweathermap.org', '/data/2.5/weather',queryPeramiter);

    final response=await http.get(uri);
    print(response.body);
    final json=jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}