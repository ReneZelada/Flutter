import 'package:flutter/material.dart';
import 'package:pokedex/Home/Home.dart';
import 'package:pokedex/Services/auth.dart';

import 'PasswordReset.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});
  @override

  _SignInState  createState()=> _SignInState();


}

class _SignInState  extends State<SignIn>{

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email ='';
  String password ='';
  String error ='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {widget.toggleView();} , icon: Icon(Icons.person), label: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 120.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  filled: true,
                  fillColor: Colors.white30,
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.white30)),
                ),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  filled: true,
                  fillColor: Colors.white30,
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.white30)),
                ),
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(33.0),
                    side: BorderSide(color: Colors.red)),
                color: Colors.red,
                elevation: 1.0,
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(()  => error = 'could not sign in with those credentials');
                    }else{
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ));
                    }
                  }
                },
              ),
              FlatButton.icon(onPressed:() {Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PasswordReset(),
                  ));}, icon: Icon(Icons.lock,color: Colors.red[400]), label: Text("Olvide mi password",style: TextStyle(color: Colors.red[400], fontSize: 15.0, fontWeight: FontWeight.bold))),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),

            ],
          ),
        ),

      ),

    );
  }

}