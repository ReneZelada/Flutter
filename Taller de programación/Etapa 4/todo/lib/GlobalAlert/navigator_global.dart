import 'package:flutter/material.dart';
import 'navigatorKey.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';



enum ConfirmAction { CANCEL, ACCEPT }

class GlobalNavigator {
  static showAlertDialog(String Title, String Message) {
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              Text(
                Title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(Message, textAlign: TextAlign.center,),
              const SizedBox(height: 20),
              const Divider(
                height: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Center(
                    child: Text(
                      "Entendido",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromRGBO(
                            38, 98, 97, 1.0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static showConfirmDialog(String Title, String Message, String idTask) {
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              Text(
                Title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(Message, textAlign: TextAlign.center,),
              const SizedBox(height: 20),
              const Divider(
                height: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () {
                 setState(() async {
                   var collection = FirebaseFirestore.instance.collection('Tasks');
                   collection
                       .doc(idTask)
                       .update({'Completed' : "true"}) // <-- Updated data
                       .then((_) => print('Success'))
                       .catchError((error) => print('Failed: $error'));
                   Navigator.of(context).pop();
                 });
                  },
                  child: const Center(
                    child: Text(
                      "Entendido",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromRGBO(
                            38, 98, 97, 1.0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () {
                      Navigator.of(context).pop();
                  },
                  child: const Center(
                    child: Text(
                      "Cancelar",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );});
      },
    );
  }

  static showAddTask () {
    String Title = '';
    String Description = '';
    showDialog(
        context:  navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8.0)), //this right here
                  child: SizedBox(
                    height: 546,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10,),
                          const Text("Agregar",  maxLines: 4, overflow: TextOverflow.ellipsis , textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 2, 3, 1.0), fontSize: 24.0, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 7,),
                          const Text('Llena los campos por favor',  maxLines: 4, overflow: TextOverflow.ellipsis , textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 2, 3, 1.0), fontSize: 18.0, fontWeight: FontWeight.normal)),
                          const SizedBox(height: 20,),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(133, 154, 140, 1),
                                    width: 1.0
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                              hintText: "Hacer app",
                            ),
                            validator: (val) => val!.isEmpty ? 'Enter a title' : null,
                            onChanged: (val){
                              setState(() => Title = val);
                            },
                          ),
                          const SizedBox(height: 5,),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(133, 154, 140, 1),
                                    width: 1.0
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                              hintText: "Crear UI/UX",
                            ),
                            validator: (val) => val!.isEmpty ? 'Enter a description' : null,
                            onChanged: (val){
                              setState(() => Description = val);
                            },
                          ),
                          const SizedBox(height: 10,),
                          Container(width: 270,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0), // shape makes the circular button
                                gradient: const LinearGradient(
                                    colors: [Color.fromRGBO(
                                        79, 121, 118, 1.0), Color.fromRGBO(
                                        38, 98, 97, 1.0)])),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent, shadowColor: Colors.transparent
                              ),
                              child: const Text('Agregar', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20),),
                              onPressed: ()  {
                                setState(() async {
                                  if (Title.isNotEmpty || Description.isNotEmpty) {
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection('Tasks').add({
                                        'Title': Title,
                                        'Description': Description,
                                        'Completed': false
                                      });
                                      Navigator.of(context).pop();
                                    } catch (err) {
                                      debugPrint('Error $err');
                                    }
                                  }else {
                                    showAlertDialog("Alert",
                                        "Por favor complete los campos");
                                  }
                                });
                              },
                            ),),
                        ],
                      ),
                    ),
                  ),);}
          );
        });
  }
}