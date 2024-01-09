import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/authentication/data/models/register_model.dart';

abstract class AuthByFirebase {
  Future<UserCredential> signInWithMailAndPass(
      {required String email, required String password});

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
}
