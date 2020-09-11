import 'package:flutter/material.dart';
import 'package:instafire/Services/auth.dart';
import 'package:toast/toast.dart';


class PasswordReset extends StatefulWidget {

  final Function toggleView;
  PasswordReset({this.toggleView});
  @override

  _PasswordResetState  createState()=> _PasswordResetState ();


}

class _PasswordResetState  extends State<PasswordReset>{

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email ='';
  String error ='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text('Sign in to Quinek'),
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
              SizedBox(height: 20.0),
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
              RaisedButton(
                color: Colors.red[400],
                child: Text(
                  'Enviar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    await _auth.resetPassword(email);
                    Toast.show("Por favor revisa tu correo electronico", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                  }
                },
              ),
              //  FlatButton.icon(onPressed:() {}, icon: Icon(Icons.lock), label: Text("Olvide mi password",style: TextStyle(color: Colors.red[400], fontSize: 15.0, fontWeight: FontWeight.bold))),
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