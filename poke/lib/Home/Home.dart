import 'dart:async';
import 'dart:convert';


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
  int present = 0;
  int perPage = 5;

  TextEditingController editingController = TextEditingController();
  String url = 'https://pokeapi.co/api/v2/pokemon/';
   List? data;

  Future<List?> makeRequest() async {
    var response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      setState(() {
        var extractData = json.decode(response.body);
        data = extractData["results"];
      });
      return data;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }


  @override
  void initState() {
    super.initState();
     makeRequest();
  }

  void loadMore() {
    setState(() {
      if((present + perPage )> data!.length) {
        data?.addAll(
            data!.getRange(present, data!.length));
      } else {
        data?.addAll(
            data!.getRange(present, present + perPage));
      }
      present = present + perPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poke Dex'),
        backgroundColor: Colors.red,
        elevation: 0.0,
        actions: <Widget>[

        ],
      ),
      body: NotificationListener<ScrollNotification>(
    onNotification: (ScrollNotification scrollInfo) {
      if (scrollInfo.metrics.pixels ==
          scrollInfo.metrics.maxScrollExtent) {
        loadMore();
      }
      return true;
    },
        child: Column(
          children: <Widget>[

            Expanded(
              child: ListView.builder(
                  itemCount: data == null ? 0 : data?.length,
                  itemBuilder: (BuildContext context, i) {
                    return Card(
                      color: Colors.redAccent,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        onTap: () => {
                         },
                        child: Stack(
                          children: <Widget>[
                            Row(
                                children: <Widget>[Container(
                                  width: 120,
                                  height: 120,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: new AssetImage('assets/pokeball.png'),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                        child: Image.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"+(i+1).toString()+".png", fit: BoxFit.cover,)
                                    ),
                                  ),
                                ),
                                  Column(children: [
                                    Text(data![i]["name"].toString().toUpperCase(),style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
                                    Text("#0"+i.toString().toUpperCase(),style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
                                  ],)
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