import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:toast/toast.dart';


class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: Firestore.instance.collection("Posts").where("Tipo", isEqualTo: "Feed").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('No hay resultados..',style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold));
        return new ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10.0),
          shrinkWrap: true,
          children: snapshot.data.documents.map((document) {
            return new Container(
              child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Positioned(
                        bottom: 0,
                        left: 3,
                        // child: Text(document['Nombre'],style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)),
                        child:  Container(
                          margin: EdgeInsets.all(20),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(document['UserFotod']),
                                fit: BoxFit.fill
                            ),
                          ),
                        ),

                      ),
                      Text( document['User'],
                        style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ]),
              Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                onTap: () => {
                  /*     print(document['Nombre']),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewScreen(text: document['Nombre'],),
                      ))*/
                },
                child: Stack(
                  children: <Widget>[

                    Image.network(document['Foto'],
                        width: 340,
                        height: 370,
                        fit: BoxFit.cover),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 45,
                        width: 340,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(55.0),
                          color: Colors.white,//Color(0xff0F0F0F),
                        ),
                        child: Center(
                          child: Text( document['User'],
                            style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
              ),
              elevation: 5,
              margin: EdgeInsets.all(30),

              //title: new Text(document['Nombre']),
              )]

              ),
              );
          }).toList(),
        );
      },
    );

  }

}
