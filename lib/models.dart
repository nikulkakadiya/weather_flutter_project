/*
{
"coord": {
"lon": 72.8333,
"lat": 21.1667
},
"weather": [
{
"id": 802,
"main": "Clouds",
"description": "scattered clouds",
"icon": "03d"
}
],
"base": "stations",
"main": {
"temp": 304.14,
},
"name": "Surat",

}*/
class WeatherInfo{
  final String? description;
  final String? icon;

  WeatherInfo({
    this.description,
    this.icon,
  });

  factory WeatherInfo.fromJson(Map<String,dynamic> json){
    final description=json['description'];
    final icon=json['icon'];
    return WeatherInfo(description: description,icon: icon);
  }

}
class TemperatureInfo{
  final double? temperatur;

  TemperatureInfo({this.temperatur});
  factory TemperatureInfo.fromJson(Map<String,dynamic> json){
    final temperatur=json['temp'];
    return TemperatureInfo(temperatur: temperatur);
  }
}

class WeatherResponse{
  final String? cityName;
  final TemperatureInfo? tempInfo;
  final WeatherInfo? weatherInfo;

  String get iconUrl{
    return 'https://openweathermap.org/img/wn/${weatherInfo!.icon}@2x.png';
  }

  WeatherResponse({
    this.cityName,
    this.tempInfo,
    this.weatherInfo,
  });

  factory WeatherResponse.fromJson(Map<String,dynamic> json){
    final cityName=json['name'];

    final tempInfoJson=json['main'];
    final tempInfo=TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson=json['weather'][0];
    final weatherInfo=WeatherInfo.fromJson(weatherInfoJson);

    return WeatherResponse(cityName: cityName,tempInfo: tempInfo,weatherInfo: weatherInfo);
  }
}