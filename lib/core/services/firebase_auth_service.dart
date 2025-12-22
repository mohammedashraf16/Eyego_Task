import 'dart:developer';

import 'package:eyego_task/core/database/cache/cache_helper.dart';
import 'package:eyego_task/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        "Exception in FirebaseAuthService.createUserWithEmailAndPassword : ${e.toString()} code: ${e.code}",
      );
      if (e.code == 'weak-password') {
        throw CustomException(message: "The password is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
          message: "You are already registered. Please log in",
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
          message: "Please check your internet connection.",
        );
      } else {
        throw CustomException(
          message: "Something went wrong. Please try again.",
        );
      }
    } catch (e) {
      log(
        "Exception in FirebaseAuthService.createUserWithEmailAndPassword : ${e.toString()}",
      );
      throw CustomException(message: "Something went wrong. Please try again.");
    }
  }

  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        "Exception in FirebaseAuthService.signInWithEmailAndPassword : ${e.toString()} code: ${e.code}",
      );
      if (e.code == 'user-not-found') {
        throw CustomException(message: "Incorrect email or password.");
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: "Incorrect email or password.");
      } else if (e.code == 'invalid-credential') {
        throw CustomException(message: "Incorrect email or password.");
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
          message: "Please check your internet connection.",
        );
      } else {
        throw CustomException(
          message: "Something went wrong. Please try again",
        );
      }
    } catch (e) {
      log(
        "Exception in FirebaseAuthService.signInWithEmailAndPassword : ${e.toString()}",
      );
      throw CustomException(message: "Something went wrong. Please try again");
    }
  }
}
