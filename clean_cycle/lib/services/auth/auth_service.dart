import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // get instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // get currrent user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  //Sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      // try sign user in
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    }
    // catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Sign up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      // try sign user up
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    }
    // catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
