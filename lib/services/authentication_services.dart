import 'package:firebase_auth/firebase_auth.dart';
import 'package:crud/database_manager/database_manager.dart';

class AuthenticationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future createNewUser(String name, String email, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseManager().createUserData(name, "?", "", user!.uid);
    } catch (e) {
      print(e.toString());
    }
  }

  Future loginUser(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
