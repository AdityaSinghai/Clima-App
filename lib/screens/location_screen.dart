import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  AssetImage backgroundImage;
  var windSpeed;
  var humidity;
  var minTemp;
  var maxTemp;
  var weatherInfo;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData){

    if(weatherData == null) {
      temperature = 0;
      weatherIcon = 'Error';
      weatherMessage = 'Unable to get weather data';
      cityName = '';
      backgroundImage = weather.getBackground(800);
      windSpeed = '--/km-h';
      return;
    }
    var temp = weatherData['main']['temp'];
     temperature = temp.toInt();
     var condition = weatherData['weather'][0]['id'];
     weatherIcon = weather.getWeatherIcon(condition);
     cityName = weatherData['name'];
     backgroundImage = weather.getBackground(condition);
     windSpeed = weatherData['wind']['speed'];
     humidity = weatherData['main']['humidity'];
     minTemp = weatherData['main']['temp_min'];
     maxTemp = weatherData['main']['temp_max'];
     weatherInfo = weatherData ['weather'][0]['description'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: ()  async{
                      var weatherData = await weather.getLocationWeather();
                      setState(() {
                        updateUI(weatherData);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: ()  async{
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData = await weather.getCityWeather(typedName);
                        setState(() {
                          updateUI(weatherData);
                        });

                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$cityName',
                      style: kCityNameTextStyle,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '$temperature',
                          style: kTempTextStyle,
                        ),
                        Text(
                          '°C',
                          style: TextStyle(
                            fontSize: 50.0,
                          ),
                        ),
                        Text(
                          weatherIcon,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                    Text(
                        weatherInfo,
                      style: kWindInfoTextStyle,
                    ),
                    Container(
                        height:1.0,
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
                      ),
                    Text(
                      'Wind Speed : $windSpeed km/h',
                      style: kWindInfoTextStyle,
                    ),
                    Text(
                      'Humidity: $humidity%',
                      style: kWindInfoTextStyle,
                    ),
                    Text(
                      'Min/Max temperature: $minTemp °C/$maxTemp °C',
                      style: kWindInfoTextStyle,
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}



