import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  static final GoogleAuth _ins = GoogleAuth._();

  late GoogleSignIn _googleSignIn;

  GoogleAuth._() {
    _googleSignIn = GoogleSignIn();
  }

  factory GoogleAuth() {
    return _ins;
  }

  Future<GoogleSignInAccount?> googleSignIn() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) return null;
      final googleAuth = await account.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);

      return account;
    } on Exception catch (error) {
      // Handle err
      debugPrint('[Google signin error]:  $error');
      return null;
    } catch (error) {
      debugPrint('[Google signin error]:  $error');
      return null;
    }
  }

  Future<GoogleSignInAccount?> googleSignOut() async {
    return _googleSignIn.signOut();
  }
}
