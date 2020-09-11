import 'package:flutter/material.dart';
import 'package:instafire/Autentication/autenticate.dart';
import 'package:instafire/Home/Home.dart';
import 'package:instafire/Models/user.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}