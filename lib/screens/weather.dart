//Carlos Daniel Taveras Liranzo
//2021-2021
// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class weather extends StatefulWidget {
  const weather({super.key});

  @override
  State<weather> createState() => _weatherState();
}

class _weatherState extends State<weather> {
  // String apiKey = '96d229af3e0cc12c39095846f05861ba'; 
  // String city = 'Santo Domingo,DO'; 
  String _imageUrl = "";
  String temp = "";
  String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=Santo%20Domingo,DO&appid=96d229af3e0cc12c39095846f05861ba&units=metric&lang=es';


  Map<String, dynamic> weatherData = {};

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
        temp = weatherData['weather'][0]['main'];
        switch (temp) {
          case 'Clear':
            _imageUrl ='clear.png';
            break;

          case 'Rain':
              _imageUrl ='rain.png';
              break;

          case 'Snow':
              _imageUrl ='snow.png';
              break;

          case 'Clouds':
              _imageUrl ='cloud.png';
              break;

          case 'Haze':
              _imageUrl ='mist.png';
              break;

          default:
              _imageUrl ='404.png';
        }
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    String temperature = weatherData['main']['temp'].toString();
    String weatherDescription = weatherData['weather'][0]['description'];
    String countryname = weatherData['name'].toString(); 
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en República Dominicana'),
      ),
      body: Center(
        child: weatherData.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                _imageUrl.isNotEmpty
                ? Image.asset(
                    _imageUrl,
                     width: 400,
                    height: 400,
                  )
                : Container(),
                SizedBox(height: 16),
                  Text(
                    'Temperatura: $countryname',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Temperatura: $temperature°C',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Clima: $weatherDescription',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}