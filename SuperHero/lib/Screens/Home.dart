import 'dart:async';
import 'dart:convert';

//import 'package:basic_utils/basic_utils.dart';
import 'package:SuperHero/Screens/Details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

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
   // makeRequest();
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
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                onFieldSubmitted: (val){
                  setState(() { url = "https://superheroapi.com/api/10222983375945201/search/"+val;
                  makeRequest();
                  print(val);});
                },
                keyboardType: TextInputType.visiblePassword,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  contentPadding: EdgeInsets.all(20.0),
                  filled: true,
                  fillColor: Colors.white30,
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white30)),
                ),

              ),),
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
                                  Image.network(data[i]["image"]["url"],
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.fill),
                                  Column(children: [
                                    Text(data[i]["name"].toString().toUpperCase(),style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)),
                                    Text(data[i]["biography"]["full-name"].toString().toUpperCase(),style: TextStyle(color: Colors.grey, fontSize: 14.0, fontWeight: FontWeight.bold)),
                                  ],),

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

