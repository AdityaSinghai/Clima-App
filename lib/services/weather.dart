import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/cupertino.dart';

const  apiKey = 'e7d964102021ae8de657080bac2e14e5';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async{

      NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
      var weatherData = await networkHelper.getData();
      return weatherData;
  }

  Future<dynamic> getLocationWeather() async{
    Location location  = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  AssetImage getBackground(int condition){
    if (condition < 300) {
      return AssetImage('images/ThunderStorm.jpg');
    } else if (condition < 400) {
      return AssetImage('images/Drizzle.jpg');
    } else if (condition < 600) {
      return AssetImage('images/RainFall.jpg');
    } else if (condition < 700) {
      return AssetImage('images/snowfall.jpg');
    } else if (condition < 800) {
      return AssetImage('images/DarkClouds.jpg');
    } else if (condition == 800) {
      return AssetImage('images/Sunny.jpg');
    } else if (condition <= 804) {
      return AssetImage('images/Cloudy.jpg');
    } else {
      return AssetImage('images/Sunny.jpg');
    }
  }

}
