import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instafire/Models/user.dart';



class DataBaseService{

  final String uid;
  DataBaseService( {this.uid
  });

  final FirebaseAuth _auth = FirebaseAuth.instance;
  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    User(uid:user.uid);

  }

  final CollectionReference quinekCollection = Firestore.instance.collection('Restaurantes');

  Future updateUserData(String Nombre, int Numero, String Imagen) async{
    return await quinekCollection.document(uid).setData({
      // you need to send the data to update here
    });
  }

  Stream<QuerySnapshot>get restaurants{
    return quinekCollection.snapshots();
  }



}