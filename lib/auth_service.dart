import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  Future<String?> registration({required email, required password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({required email, required password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return 'The password is invalid.';
      } else if (e.code == 'user-not-found') {
        return 'There is no user record corresponding to this identifier. The user may have been deleted.';
      }
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }
}
