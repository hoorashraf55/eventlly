import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
 static Future<User> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user?.updateProfile(displayName: name);
      await credential.user?.updateDisplayName(name);
      await credential.user?.sendEmailVerification();
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }else{
        throw e.message??"";
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw "Invalid Email or Password";
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw "Invalid Email";
    } catch (e) {
      rethrow;
    }
  }
}
