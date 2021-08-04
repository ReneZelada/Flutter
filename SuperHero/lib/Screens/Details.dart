import 'dart:convert';

import 'package:SuperHero/Screens/Home.dart';
import 'package:SuperHero/Screens/Pos.dart';
import 'package:SuperHero/sql/sqlite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

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
    var url = widget.data["id"];
    debugPrint(url);
    final response = await http.get("https://superheroapi.com/api/10222983375945201/"+url);
    if (response.statusCode == 200) {
      get = json.decode(response.body.toString());
      setState(() {
        isLoad = false;
      });
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nombre "+ widget.data["name"]),backgroundColor: Colors.red, elevation: 0.0,),
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

            Row(children: [
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Poss(text: get['image']['url'],),
                        ))},
                  child: Stack(
                    children: <Widget>[
                        Image.network(get['image']['url'],
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
              Column(children: [
                IconButton(icon: const Icon(Icons.star_border),
                  color: Colors.grey,
                  onPressed: () async {
                  },),
                Text( get['name'],style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold)),
                Text("Gender: " +get['appearance']['gender'],style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
                Text("Race: " +get['appearance']['race'],style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
                Text("Eye-Color: " +get['appearance']['eye-color'],style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
                Text("Hair-color: " +get['appearance']['hair-color'],style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
              ],
              ),
            ],),

      Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                child: Stack(
                  children: <Widget>[
                    Row(children: [
                      SizedBox(width: 70,),
                      Column(children: [

                        Text(get['powerstats']['intelligence'],style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
                        Icon(Icons.sentiment_very_satisfied)
                      ],),
                      SizedBox(width: 20,),
                      Column(children: [
                        Text(get['powerstats']['strength'],style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
                        Icon(Icons.sentiment_very_satisfied)
                      ],),
                      SizedBox(width: 20,),
                      Column(children: [
                        Text(get['powerstats']['speed'],style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
                        Icon(Icons.sentiment_very_satisfied)
                      ],),
                      SizedBox(width: 20,),
                      Column(children: [
                        Text(get['powerstats']['durability'],style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
                        Icon(Icons.sentiment_very_satisfied)
                      ],),
                      SizedBox(width: 20,),
                      Column(children: [
                        Text(get['powerstats']['power'],style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
                        Icon(Icons.sentiment_very_satisfied)
                      ],),
                      SizedBox(width: 20,),
                      Column(children: [
                        Text(get['powerstats']['combat'],style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
                        Icon(Icons.sentiment_very_satisfied)
                      ],)

                    ],)
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33.0)
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
          ],
        ),

      ),);
  }
}