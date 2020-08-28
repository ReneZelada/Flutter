import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjob/JsonPage.dart';
import 'package:flutterjob/screens/Pasta.dart';
import 'package:flutterjob/screens/drinks.dart';
import 'package:flutterjob/screens/proteins.dart';
import 'package:flutterjob/screens/salads.dart';
import 'package:flutterjob/screens/wraps.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: profileView()// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget profileView() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(height: 50, width: 50 ,child: Icon(Icons.arrow_back_ios, size: 24,color: Colors.white,), decoration: BoxDecoration(border: Border.all(color: Colors.orange), borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topLeft,
              colors: [Colors.redAccent, Color.fromRGBO(244, 175, 29, 1)]
          ),),),
              Text('Chick & Salsa', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Color.fromRGBO(27, 27, 38, 1)),),
              Container(height: 24,width: 24)
            ],
          ),
        ),

    Padding(
    padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
        child:     Material(
          elevation: 20.0,
          shadowColor: Colors.black54,
          child:  TextFormField(
            onFieldSubmitted: (val){
              Navigator.push(
                  context,
                  MaterialPageRoute(

                  ));
            },
            keyboardType: TextInputType.visiblePassword,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Buscar',
                prefixIcon: Icon(Icons.zoom_in),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              filled: true,
              fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 1),
                )
            ),

          ),
        )  ),



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
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 4),
            child:
                Container(height: 250,
                child: DefaultTabController(
                  length: 6,
                  child: new Scaffold(
                    appBar: new PreferredSize(
                      preferredSize: Size.fromHeight(kToolbarHeight),
                      child: new Container(
                        color: Colors.white,

                        child: new SafeArea(
                          child: Column(
                            children: <Widget>[
                              new Expanded(child: new Container()),
                              new TabBar(
                                isScrollable: true,
                                unselectedLabelColor: Colors.blue,
                                indicatorSize: TabBarIndicatorSize.label,
                                tabs: [
                                  new Text("Todos", style: TextStyle(color: Color.fromRGBO(27, 27, 38, 1), fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  new Text("Ensaladas", style: TextStyle(color: Color.fromRGBO(27, 27, 38, 1), fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  new Text("Bebidas", style: TextStyle(color: Color.fromRGBO(27, 27, 38, 1), fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  new Text("Wraps", style: TextStyle(color: Color.fromRGBO(27, 27, 38, 1), fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  new Text("Pasta", style: TextStyle(color: Color.fromRGBO(27, 27, 38, 1), fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  new Text("Carnes", style: TextStyle(color: Color.fromRGBO(27, 27, 38, 1), fontSize: 15.0, fontWeight: FontWeight.bold))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: new TabBarView(
                      children: <Widget>[
                        Container(
                          height: 240, child: salads(),
                        ),
                        Container(
                          height: 240, child: salads(),
                        ),
                        Container(
                          height: 240, child: drinks(),
                        ),
                        Container(
                          height: 240, child: wraps(),
                        ),
                        Container(
                          height: 240, child: Pasta(),
                        ),
                        Container(
                          height: 240, child: proteins(),
                        ),

                      ],
                    ),
                  ),
                ),)
                )
    ])

        )),
      ],
    );
  }
}

