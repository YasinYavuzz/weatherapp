import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'location.dart';

const apiKey = "cd2a806afdcc70e043cc8c61241ab5e3";

class WeatherDsiplayData{
  WeatherDsiplayData({required this.weatherIcon,required this.weatherImage});
  Icon weatherIcon;
  AssetImage weatherImage;
}


class WeatherData {
  WeatherData({
    required this.locationData,
  });
  LocationHelper locationData;
  late double currentTempeture; // late yazarak artık constructor içerisinde yazmak zorunda değilim.
  late int currentConsition; // // late yazarak artık constructor içerisinde yazmak zorunda değilim.

  Future<void> getTempeture() async {
    
    // bunun bir link olduğunu belirtmek için Uri tipine parse etmemiz gerekiyor.
    Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric"));// get diye bir fonksiyonu var

    // eğer response başarılı ise yani bir değer dönmüşse
    if(response.statusCode == 200){ // => status code 200 ise başarılı
      String data = response.body; // => response dan dönen json verisini alıyorum string olarak
      var jsonData = jsonDecode(data); // gelen verileri jsona dönüştürüyorum.
      // Hata dönmesi durumunda 
      try {
        currentTempeture = jsonData["main"]["temp"];
        currentConsition = jsonData["weather"][0]["id"];
        print("temp : $currentTempeture");
      } catch (e) {
        print(e);
      }
    }else{
      print("Apiden değer gelmiyor");
    }
  }
  WeatherDsiplayData weatherDsiplayData(){
    if (this.currentConsition < 600) {
      return WeatherDsiplayData(weatherIcon: Icon(FontAwesomeIcons.cloud,size: 75,color: Colors.white,), weatherImage: AssetImage('assets/bulutlu.png'));
    }
    else{
      // Hava iyi gece gündüz kontrolü
      var now = new DateTime.now();
      if (now.hour >= 19) {
        return WeatherDsiplayData(weatherIcon: Icon(FontAwesomeIcons.moon,size: 75,color: Colors.white,), weatherImage: AssetImage('assets/gece.png'));
      }else{
        return WeatherDsiplayData(weatherIcon: Icon(FontAwesomeIcons.sun,size: 75,color: Colors.white,), weatherImage: AssetImage('assets/gunesli.png'));
      }
    }
  }
}
