import 'dart:async';
import 'dart:convert';

//import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Offline(),
    );
  }
}

class Offline extends StatefulWidget {
  @override
  _OfflineState createState() => _OfflineState();
}

class _OfflineState extends State<Offline> {
  TextEditingController editingController = TextEditingController();
  String url = 'https://superheroapi.com/api/10222983375945201/search/bat';
  List data;

  Future<String> makeRequest() async {
    var response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var extractData = json.decode(response.body);
      data = extractData["results"];
    });
  }


  @override
  void initState() {
    super.initState();
    makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Super Hero'),
        backgroundColor: Colors.red,
        elevation: 0.0,
        actions: <Widget>[

        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("no data"),
          ],
        ),
      ),
    );
  }
}
