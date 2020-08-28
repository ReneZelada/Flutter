import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';


class details extends StatelessWidget {
  final String text;
  final String text2;
  final String text3;
  final String text4;

  details({Key key, @required this.text, this.text2,this.text3,this.text4}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(

        floatingActionButtonLocation:
        FloatingActionButtonLocation.startTop,

        floatingActionButton: Padding(
          padding: const EdgeInsets.all(0.0),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
                width: 60,
                child: RaisedButton(
                  onPressed: () {
                            Navigator.pop(context);

                  },
                  child: Icon(Icons.arrow_back_ios, size: 24,color: Colors.deepOrangeAccent,),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    bottomLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0),
                    bottomRight: const Radius.circular(10.0),
                  )),
                ),),
            ],
          ),
        ),
        body: Column(
        children: <Widget>[
           Image.asset('assets/images/'+text4, width: 500,
                height: 300,fit: BoxFit.cover),

          Expanded(child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 5, blurRadius: 7, offset: Offset(0, 3),),
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                        padding: const EdgeInsets.all(15.0),
                 child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                          children: <Widget>[
                      new Row( children: <Widget>[
                        Text(text,style: TextStyle(color: Colors.indigo, fontSize: 25.0, fontWeight: FontWeight.bold)),
                        Spacer(),
                        Image.asset('assets/icons/icon.png', width: 30,
                            height: 40,fit: BoxFit.fill),
                      ],),
                            new Row( children: <Widget>[
                              Text("",style: TextStyle(color: Colors.indigo, fontSize: 25.0, fontWeight: FontWeight.bold)),
                              Spacer(),
                              Text(text2,style: TextStyle(color: Colors.greenAccent, fontSize: 15.0, fontWeight: FontWeight.bold)),
                            ],),
                          ])

                    ),
                  ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text("Descripcion",style: TextStyle(color: Colors.indigo, fontSize: 25.0, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(text3,style: TextStyle(color: Colors.black, fontSize: 15.0,)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                 child: RaisedButton(
                   onPressed: () { },
                   textColor: Colors.white,
                   padding: const EdgeInsets.all(0.0),
                   child: Container(
                     width: 300,
                     decoration: new BoxDecoration(
                         gradient: new LinearGradient(
                             colors: [Color.fromRGBO(244, 175, 29, 1),Colors.redAccent ]
                         ),
                         borderRadius: BorderRadius.all(Radius.circular(10.0))
                     ),
                     padding: const EdgeInsets.all(10.0),
                     child: Text(
                       "Agregar al carrito",
                       textAlign: TextAlign.center,
                     ),
                   ),
                 ),
                ),
              ],
            ),
          ))
        ],
      )
    );
  }
}
