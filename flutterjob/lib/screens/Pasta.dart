import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterjob/screens/details.dart';

class Pasta extends StatefulWidget {
  @override
  _PastaState createState() => _PastaState();
}

class _PastaState extends State<Pasta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(builder: (context, snapshot){
          var showData=json.decode(snapshot.data.toString());
          return GridView.count(
            // crossAxisCount is the number of columns
            crossAxisCount: 2,
            // This creates two columns with two items in each column
            children: List.generate(1, (index) {
              return Center(
                child: Card(
                  child: InkWell(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => details(text: showData['pastas'][index]['name'],text2: showData['pastas'][index]['price'],text3: showData['pastas'][index]['description'],text4: showData['pastas'][index]['image'],),
                          ))},
                    child: Stack(
                      children: <Widget>[
                        Image.asset('assets/images/'+showData['pastas'][index]['image'],width: 175,
                            height: 450,fit: BoxFit.cover),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            height: 60,
                            width: 168,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              color: Colors.white,
                              // color: Color.fromRGBO(159, 159, 159, 0.50),//Color(0xff0F0F0F),
                            ),
                            child: Center(

                              child: Column(
                                  children: <Widget>[
                                    Row(
                                        children: <Widget>[
                                          Text( showData['pastas'][index]['name'],
                                            style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                                          ),Spacer(),
                                          Text( showData['pastas'][index]['price'],
                                            style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                                          )
                                        ]),
                                    Flexible(
                                      child: Text(showData['pastas'][index]['description'],
                                          overflow: TextOverflow.ellipsis),
                                    )
                                  ]),
                            ),

                          ),
                        ),
                      ],

                    ),
                    //    showData['salads'][index]['name']
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                ),
              );
            }),
          );
        }, future: DefaultAssetBundle.of(context).loadString("assets/emprecord.json"),

        ),
      ),

    );
  }
}