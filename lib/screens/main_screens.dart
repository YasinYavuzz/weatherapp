import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weatherapp/utils/weather.dart';

class MainScreen extends StatefulWidget {
  // buraya ekleyeceğiz.
  final WeatherData weatherData;
  const MainScreen({super.key, required this.weatherData});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage weatherImage;

  void updateDisplayInfo(WeatherData weatherData){
    setState(() {
      temperature = weatherData.currentTempeture.round();
      WeatherDsiplayData weatherDsiplayData = weatherData.weatherDsiplayData();
      weatherImage = weatherDsiplayData.weatherImage;
      weatherDisplayIcon = weatherDsiplayData.weatherIcon;
    });
  }
  @override
  void initState() {
    
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(), // Genişleyebilir
        decoration: BoxDecoration(
            image: DecorationImage(
                image: weatherImage, fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            SizedBox(height: 15,),
            Container(margin: EdgeInsets.only(left: 40),child: Text('${this.temperature}°',style: TextStyle(color: Colors.white,fontSize: 80,letterSpacing: -5,fontWeight: FontWeight.w300),))
          ],
        ),
      ),
    );
  }
}
