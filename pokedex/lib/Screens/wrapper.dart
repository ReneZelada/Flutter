import 'package:flutter/material.dart';
import 'package:pokedex/Autentication/Start.dart';

import 'package:pokedex/Home/Home.dart';
import 'package:pokedex/Models/user.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null){
      return Start();
    }else{
      return Home();
    }
  }
}