import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../features/authentication/data/models/register_model.dart';

abstract class AuthByFirebase {
  Future<UserCredential> signInWithMailAndPass(
      {required String email, required String password});

  Future<UserCredential> googleSignIn();
  Future<UserCredential> facebookSignIn();

  Future<UserCredential> createUserWithEmailAndPass(
      {required RegisterBody registerBody});
}

class AuthByFirebaseImpl implements AuthByFirebase {
  final _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signInWithMailAndPass(
      {required String email, required String password}) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<UserCredential> createUserWithEmailAndPass(
      {required RegisterBody registerBody}) async {
    return await _auth.createUserWithEmailAndPassword(
        email: registerBody.email!, password: registerBody.password!);
  }

  @override
  Future<UserCredential> googleSignIn() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<UserCredential> facebookSignIn() async{

    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
