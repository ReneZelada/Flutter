import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instafire/Feed/Feed.dart';
import 'package:instafire/Services/auth.dart';
import 'package:intl/intl.dart';



class Home extends StatelessWidget {

  final AuthService  _auth = AuthService();


  @override
  Widget build(BuildContext context) {

    var now = new DateTime.now();
    var formatter = new DateFormat('H');
    int Hour = int.parse(formatter.format(now));


    return Scaffold(


      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('InstaFire'),
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: <Widget>[

          FlatButton.icon(onPressed: () async { await _auth.signOut();}, icon: Icon(Icons.power_settings_new, color: Colors.red,), label: Text(''))
        ],
      ),

      body: new Center(

        child: new Container(

          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Text( '',
                style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
              ),


              Container(
                height: 550,
                child: StreamBuilder(
                  stream: Firestore.instance.collection("Posts").where("Tipo", isGreaterThanOrEqualTo:"Feed").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return new Text('Loading...');
                    return new ListView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(10.0),
                      shrinkWrap: true,
                      children: snapshot.data.documents.map((document) {
                        return new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(document['UserFotod']),
                                      fit: BoxFit.fill
                                  ),
                                ),
                              ),
                              Text("  "+document['User'],style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
                            ]),
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                onTap: () => {
                                  print(document['Nombre']),
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      //  builder: (context) => NewScreen(text: document['Nombre'],),
                                      ))},
                                child: Stack(
                                  children: <Widget>[
                                         Image.network(snapshot.data.documents[0]['Foto'],
                                              width: 400,
                                              height: 300,
                                              fit: BoxFit.cover),
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(33.0)
                              ),
                              elevation: 5,
                              margin: EdgeInsets.all(10),

                              //title: new Text(document['Nombre']),
                            ),
                            Row(children: <Widget>[
                              FlatButton.icon(onPressed: () async { /*await _auth.signOut();*/}, icon: Icon(Icons.favorite, color: Colors.red,), label: Text('')),


                            ])
                          ],
                        );


                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}