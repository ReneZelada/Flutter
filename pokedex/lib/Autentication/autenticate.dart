import 'package:flutter/material.dart';
import 'package:pokedex/Autentication/Register.dart';
import 'package:pokedex/Autentication/sign_in.dart';




class Authenticate extends StatefulWidget{

  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(showSignIn == true){
      return SignIn(toggleView: toggleView);
    }
    else{
      return Register(toggleView: toggleView);
    }

  }
}