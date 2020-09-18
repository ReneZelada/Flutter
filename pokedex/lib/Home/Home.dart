import 'dart:async';
import 'dart:convert';

//import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/Services/auth.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController editingController = TextEditingController();
  String url = 'https://pokeapi.co/api/v2/pokemon/';
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
    final AuthService  _auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon'),
        backgroundColor: Colors.red,
        elevation: 0.0,
        actions: <Widget>[

          FlatButton.icon(onPressed: () async {
            await _auth.signOut();
          }, icon: Icon(Icons.power_settings_new, color: Colors.white,), label: Text('')),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[

            Expanded(
              child: ListView.builder(
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, i) {
                    return Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details(data[i]),
                              ))},
                        child: Stack(
                          children: <Widget>[
                            Row(
                                children: <Widget>[
                                  Image.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"+(i+1).toString()+".png",
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.fill),
                                  Text(data[i]["name"].toString().toUpperCase(),style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)),
                                ]
                            )
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33.0)
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class Details extends StatefulWidget {
  Map data;

  Details(this.data);

  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Map get;
  bool isLoad = true;

  getData() async {
    setState(() {
      isLoad = true;
    });
    var url = widget.data["url"];
    debugPrint(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      get = json.decode(response.body.toString());
      setState(() {
        isLoad = false;
      });
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details "+ widget.data["name"]),backgroundColor: Colors.red, elevation: 0.0,),
      body: _snapshot(context),
    );
  }

  Widget _snapshot(BuildContext context) {
    if (isLoad) return Center(child: CircularProgressIndicator());
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                child: Stack(
                  children: <Widget>[
                    Image.network(get['sprites']['front_default'],
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill),

                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33.0)
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
            Text( get['name'],style: TextStyle(color: Colors.black, fontSize: 35.0, fontWeight: FontWeight.bold)),
            Text("Weight: " +get['weight'].toString(),style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)),
            Text("Height: " +get['height'].toString(),style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)),

          ],
        ),
      ),);
  }
}