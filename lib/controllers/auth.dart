import "package:firebase_auth/firebase_auth.dart";

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return result.user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign up with email and pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch(e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use');
        return "Email is already in use";
      }
      else {
        return null;
      }
    }
  }

  Future<void> removeUser() async {
    try {
      // Get the currently authenticated user
      User? user = FirebaseAuth.instance.currentUser;
      await user?.delete();
      print("User deleted successfully!");
    } catch (e) {
      print("Error removing user: $e");
      // Handle the error as needed
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}