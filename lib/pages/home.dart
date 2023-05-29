import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather1/pages/service/weatherModel.dart' as k;
import 'dart:convert';

import 'package:weather1/pages/service/weatherModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoaded = false;
  num temp = 0;
  num press = 0;
  num hum = 0;
  num clou = 0;
  String cityName = '';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xff485563),
              Color(0xff29323c),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: Visibility(
            visible: isLoaded,
            replacement: const Center(child: CircularProgressIndicator()),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: TextFormField(
                        onFieldSubmitted: (String s) {
                          setState(() {
                            cityName = s;
                            getCityWeather(s);
                            isLoaded = false;
                            controller.clear();
                          });
                        },
                        controller: controller,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                            hintText: 'Search City',
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              size: 25,
                              color: Colors.black,
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.pin_drop_rounded,
                          color: Colors.red,
                          size: 40,
                        ),
                        Text(
                          cityName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.12,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1, 2),
                            blurRadius: 3,
                            spreadRadius: 1,
                          )
                        ]),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: const NetworkImage(
                              'https://static.vecteezy.com/system/resources/previews/010/151/095/original/thermometer-icon-sign-symbol-design-free-png.png',
                            ),
                            width: MediaQuery.of(context).size.width * 0.09,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Temperature: ${temp.toInt()} ºC',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.12,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1, 2),
                            blurRadius: 3,
                            spreadRadius: 1,
                          )
                        ]),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: const NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/2676/2676004.png',
                            ),
                            width: MediaQuery.of(context).size.width * 0.09,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'pressure: ${press.toStringAsFixed(1)} hPa',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.12,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1, 2),
                            blurRadius: 3,
                            spreadRadius: 1,
                          )
                        ]),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: const NetworkImage(
                              'https://cdn2.vectorstock.com/i/1000x1000/75/91/humidity-icon-vector-24247591.jpg',
                            ),
                            width: MediaQuery.of(context).size.width * 0.09,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'humidity: ${hum.toInt()} ',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.12,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1, 2),
                            blurRadius: 3,
                            spreadRadius: 1,
                          )
                        ]),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: const NetworkImage(
                              'https://stclares6th.files.wordpress.com/2014/05/weather-symbol.png',
                            ),
                            width: MediaQuery.of(context).size.width * 0.09,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'clouds: ${clou.toInt()} ',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getCurrentLocation() async {
    var p = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,
    );

    // ignore: unnecessary_null_comparison
    if (p != null) {
      // ignore: avoid_print
      print('Lat:${p.latitude},Long:${p.longitude}');
      getCurrentCityWeather(p);
    } else {
      // ignore: avoid_print
      print('data unavailable');
    }
  }

  getCityWeather(String cityname) async {
    Weather weather = Weather();
    var client = http.Client();
    var uri = '${k.domain}q=$cityName&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodeData = json.decode(data);
      // ignore: avoid_print
      print(data);
      weather = Weather.fromJson(decodeData);

      updateUI(weather);
      setState(() {
        isLoaded = true;
      });
    } else {
      // ignore: avoid_print
      print(response.statusCode);
    }
  }

  getCurrentCityWeather(Position position) async {
    Weather weather = Weather();
    var client = http.Client();
    var uri =
        '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodeData = json.decode(data);
      weather = Weather.fromJson(decodeData);
      // ignore: avoid_print
      print(data);
      updateUI(weather);
      setState(() {
        isLoaded = true;
      });
    } else {
      // ignore: avoid_print
      print(response.statusCode);
    }
  }

  updateUI(Weather? weather) {
    setState(() {
      if (weather == null) {
        temp = 0;
        press = 0;
        hum = 0;
        clou = 0;
        cityName = 'Not Available';
      } else {
        temp = weather.main!.temp!;

        press = weather.main!.pressure!;

        hum = press = weather.main!.humidity!;

        clou = press = weather.clouds!.all!;

        cityName = weather.name!;
      }
    });
  }
}
