import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/screens/main_screens.dart';
import 'dart:math' as math;

import 'package:weatherapp/utils/location.dart';
import 'package:weatherapp/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  
  late LocationHelper locationData;
  Future<void> getLocationData() async{
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if(locationData.latitude == null || locationData.longitude == null){
      print("Konum bilgileri gelmiyor.");

    }
    else{
      print("latitude: " + locationData.latitude.toString());
      print("longitude: " + locationData.longitude.toString());
    }
  }
  void getWeatherData() async{
    await getLocationData();
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getTempeture();
    if(weatherData.currentTempeture == null || weatherData.currentConsition == null){
      print("API den sıcaklık veya durum bilgisi gelmiyor.");
    }
    // konum ve hava durumu bilgisini aldıktan sonra artık diğer sayfama gitmem gerek.
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(weatherData: weatherData,); // oraya verileri götürmek için
    },));
  }
  @override
  void initState() {
    super.initState();
    getWeatherData();   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.green
            ],
            transform: GradientRotation(math.pi / 2),
            tileMode: TileMode.mirror
          )
        ),
        child: Center(
          child: SpinKitFadingCircle(
            color: Color.fromARGB(255, 235, 91, 91),
            size: 100,
            duration: Duration(seconds: 1),
          ),
        ),
      ),
    );
  }
}