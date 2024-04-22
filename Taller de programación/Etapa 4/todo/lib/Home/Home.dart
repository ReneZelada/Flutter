
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../GlobalAlert/navigator_global.dart';




class Home extends StatefulWidget {
  @override
  _HomeState  createState()=> _HomeState();
}


class _HomeState  extends State<Home>{

  Widget build(BuildContext context) {

    DateTime date = DateTime.now();
    final user = FirebaseAuth.instance.currentUser;
    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('Tasks').where("Completed", isEqualTo: false).snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          if (!snapshot.hasData) {
            GlobalNavigator.showAlertDialog("Alerta", "Esta tienda no tiene productos, agrega nuevos");
          }

          return WillPopScope(
              onWillPop: () async {
                debugPrint("test");
                return true;
              },
              child: Scaffold(
                  backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                      backgroundColor: const Color.fromRGBO(
                          38, 98, 97, 1.0),
                      elevation: 0.0,
                      title:  const Text("Dashboard",maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),)
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: const Color.fromRGBO(
                        38, 98, 97, 1.0),
                    tooltip: 'Add',
                    onPressed: (){
                      GlobalNavigator.showAddTask();
                    },
                    child: const Icon(Icons.add, color: Colors.white, size: 28),
                  ),
                  body: Padding(
                      padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                      child:Column(children: [

                        SizedBox(height: 40,),
                        Container(
                            height: MediaQuery.of(context).size.height-185,
                            child:
                            ListView(
                              scrollDirection: Axis.vertical,
                              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                                print('data ${document.id}');
                                return   Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  elevation: 0,
                                  margin: EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () => {
                                      if (data["Completed"] == false)
                                      GlobalNavigator.showConfirmDialog("Alerta", "Esta seguro de marcar la tarea como completada?", document.id)
                                      else
                                        GlobalNavigator.showAlertDialog("Alerta", "La tarea ya fue completada")
                                    },
                                    child:Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      child: Row(children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 25,),
                                            Container(width: MediaQuery.of(context).size.width / 1.6,
                                              child:

                                              Row(children: [
                                                const Icon(Icons.task_alt, size: 35, color: Color.fromRGBO(38, 98, 97, 1.0),),
                                                const SizedBox(width: 10,),
                                                Text(data["Title"],maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Color.fromRGBO(38, 98, 97, 1.0), fontSize: 24, fontWeight: FontWeight.bold),)
                                              ],),
                                            ),
                                            const SizedBox(height: 15,),
                                            Text(data["Description"] , style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.normal),),
                                            Row(children: [
                                              const Icon(Icons.check),
                                              const SizedBox(width: 10,),
                                              Text(data["Completed"] == false ? "Aun no" : "Completado"  , style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal))
                                            ],),
                                          ],
                                        ),

                                      ],
                                      ),
                                    ),),
                                );
                              }).toList(),
                            )),
                      ],)
                  )
              ));});
  }
}

