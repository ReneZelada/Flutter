import 'package:firebase_auth/firebase_auth.dart';
import 'package:instafire/Models/user.dart';



class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebase(user));
    // .map(_userFromFirebase);
  }

  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      User(uid: user.uid);
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }


  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }
  Future<void> resetPassword(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
      return null;
    }

  }


  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    // Similarly we can get email as well
    //final uemail = user.email;
    return uid;
    print(uid);
    //print(uemail);
  }

  Future signOut() async{
    try{
      return  _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }

}