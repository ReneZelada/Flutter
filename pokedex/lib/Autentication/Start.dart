import 'package:flutter/material.dart';
import 'package:pokedex/Autentication/autenticate.dart';
import 'package:pokedex/Autentication/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class Start extends StatefulWidget{
  final Function toggleView;
  Start({this.toggleView});
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  bool showSignIn = true;

  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.red,
      appBar: AppBar(

        backgroundColor: Colors.red,
        elevation: 0.0,
      ),

      body: new Center(

        child: new Container(
          padding: new EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text( 'PokeFire',
                  style: TextStyle(color: Colors.white, fontSize: 80.0, fontWeight: FontWeight.bold),
                ),),

              SizedBox(height: 180,),

              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 50,
                  width: 170,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33.0),
                        side: BorderSide(color: Colors.white)),
                    color: Colors.white,
                    child: Text(
                      'Start',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Authenticate(),
                          ));
                    },
                  ),),),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}