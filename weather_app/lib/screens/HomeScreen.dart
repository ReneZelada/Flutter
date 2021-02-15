import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

@override
class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Main(),
    );
  }
}

class Main extends StatefulWidget {
  Main({Key key}) : super(key: key);

  @override
  MainState createState() => MainState();
}

class MainState extends State<Main> {
  TextEditingController cityFinder = new TextEditingController();
  var mainTemp;
  var dayOne, dayTwo, dayThree;
  var city;

  Future<void> getWeather() async {
    final String Search = cityFinder.text;
    final String appId = 'ab6dd5a2c768292e151bf2ef8193ea51';


    var response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$Search&appid=$appId&units=metric');
    var data = json.decode(response.body);
    if (response.statusCode == 404) {
      Toast.show("We can't find the city", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
    }
    if (Search.isEmpty) {
      Toast.show("Please insert a city", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
    }
    setState(() {
      mainTemp = data['main']['temp'];
      city = data['name'];
    });
  }
  List data;

  Future<String> getWeatherForecast() async {
    final String Search = cityFinder.text;
    final String appId = 'ab6dd5a2c768292e151bf2ef8193ea51';
    var response = await http.get('https://api.openweathermap.org/data/2.5/forecast?q=$Search&appid=$appId&units=metric&cnt=3');

    setState(() {
      var extractData = json.decode(response.body);
      data = extractData['list'];print(data[0]['main']['temp']);

    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [

          SizedBox(
            width: 330,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400],
                      blurRadius: 5.0,
                      spreadRadius: 1,
                    )
                  ]),
              width: 340,
              child: TextField(
                controller: cityFinder,
                onSubmitted: (callback) => {
                  getWeather(),
                  getWeatherForecast(),
                },
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Colors.redAccent,
                    labelText: 'Search city...',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none)),
                obscureText: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 10),
            child: city == null
                ? Text(
              "Write and press enter...",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700]),
              ),
            )
                : Text(
              city,
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0, bottom: 10),
            child: mainTemp == null
                ? Text(
              "",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700]),
              ),
            )
                :
            Column(
              children: <Widget>[
                 Text(
              "$mainTemp" "°C",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700]),
              ),
            ),
                Text(
                  "Forecast",
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 1, 20, 1),
              child:  Row(
              children: <Widget>[
                Card(
                  color: Colors.redAccent,
               child: Text(
                  data[0]['main']['temp'].toString() +"°C"  ,
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),),
                Card(
                  color: Colors.redAccent,
               child: Text(
                  data[1]['main']['temp'].toString() +"°C"  ,
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),),
                Card(
                  color: Colors.redAccent,
                child: Text(
                  data[2]['main']['temp'].toString() +"°C"  ,
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                  ),
                ),),),
                ],),),
              ],
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
