
import 'package:flutter/material.dart';
import 'Signin.dart';




class Signup extends StatefulWidget {

  @override

  _SignupState  createState()=> _SignupState();


}

class _SignupState  extends State<Signup>{


  String email ='';
  String password ='';


  String error ='';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 85,),
              const Text("Bienvenido",style: TextStyle(color: Color.fromRGBO(
                  38, 98, 97, 1.0), fontSize: 20.0, fontWeight: FontWeight.bold)),
              const Text("Crea una nueva cuenta",style: TextStyle(color: Color.fromRGBO(
                  38, 98, 97, 1.0), fontSize: 15.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 25,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderRadius:BorderRadius.circular(15.0)),
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(
                        left: 10.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(
                          38, 98, 97, 1.0)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),

                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
              ),
              SizedBox(height: 20.0),

              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 25,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderRadius:BorderRadius.circular(15.0)),
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(
                        left: 10.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(
                          38, 98, 97, 1.0)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
              ),
              SizedBox(height: 40.0),
              Container(
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0), // shape makes the circular button
                    gradient: LinearGradient(
                        colors: [Color.fromRGBO(
                            79, 121, 118, 1.0), Color.fromRGBO(
                            38, 98, 97, 1.0)])),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, shadowColor: Colors.transparent
                  ),
                  child: const Text(
                    'Crear',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () async {

                  },
                ),),
              SizedBox(height: 12.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Ya tienes cuenta? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignIn()));
                      },
                      child: const Text(
                        "Inicia sesión",
                        style: TextStyle(
                            color: Color.fromRGBO(
                                38, 98, 97, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    )
                  ]),
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