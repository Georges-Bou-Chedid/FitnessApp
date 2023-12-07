import "package:firebase_auth/firebase_auth.dart";

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  User? getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future? reload() async {
    try{
      var user = getCurrentUser();
      if (user != null) {
        await user.reload();
      }
    } catch (e) {
      // Check if the error is due to an expired token
      if (e is FirebaseAuthException && e.code == 'user-token-expired') {
        print("Your email has been changed");
      } else {
        print("Error: $e");
      }
    }
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
      await result.user?.sendEmailVerification();
      return result.user;
    } catch(e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          return "in-use";
        } else {
          print(e.toString());
          return null;
        }
      } else {
        print(e.toString());
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

  Future changeEmail(String newEmail, String currentPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Re-authenticate the user using their current password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updateEmail(newEmail);

      return user;
    } catch(e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          return "wrong-password";
        } else if (e.code == 'email-already-in-use') {
          return "in-use";
        } else {
          print(e.toString());
          return null;
        }
      } else {
        print(e.toString());
        return null;
      }
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