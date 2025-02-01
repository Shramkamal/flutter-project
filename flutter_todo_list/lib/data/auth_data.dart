import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todo_list/data/firestor.dart';

abstract class AuthenticationDatasource {
  Future<void> register(String email, String password, String PasswordConfirm);
  Future<void> login(String email, String password);
}

class AuthenticationRemote extends AuthenticationDatasource {
  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  @override
  Future<void> register(
      String email, String password, String PasswordConfirm) async {
    if (PasswordConfirm != password) {
      throw Exception('Passwords do not match.');
    }

    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      bool userCreated = await Firestore_Datasource().CreateUser(email);
      if (!userCreated) {
        throw Exception('Failed to create user document in Firestore');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('Email is already in use.');
      } else if (e.code == 'invalid-email') {
        throw Exception('Invalid email address.');
      } else if (e.code == 'weak-password') {
        throw Exception('Password is too weak.');
      } else {
        throw Exception('Registration error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }
}
