import 'package:firebase_auth/firebase_auth.dart';
import 'package:fsociety/core/firebase/firebase_auth/auth.dart';
import 'package:fsociety/core/firebase/firebase_store/firebase_firestore.dart';
import '../models/current_user_model.dart';
import '../models/register_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> userRegistration({required RegisterBody registerBody});

  Future<UserCredential> userLogin(
      {required String email, required String password});

  Future<UserCredential> googleSignIn();
  Future<UserCredential> facebookSignIn();

  Future<void> addUserToFireStore({required CurrentUser currentUser});

  Future<CurrentUser> getCurrentUser({required String uid});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthByFirebase authByFirebase;
  final StorageByFirebase storageByFirebase;

  AuthRemoteDataSourceImpl({
    required this.authByFirebase,
    required this.storageByFirebase,
  });

  @override
  Future<UserCredential> userLogin(
      {required String email, required String password}) async {
    return await authByFirebase.signInWithMailAndPass(
        email: email, password: password);
  }

  @override
  Future<CurrentUser> getCurrentUser({required String uid}) async {
    return await storageByFirebase.getCurrentUser(uid: uid);
  }

  @override
  Future<void> addUserToFireStore({required CurrentUser currentUser}) async {
    return await storageByFirebase.addUserToFireStore(currentUser: currentUser);
  }

  @override
  Future<UserCredential> userRegistration(
      {required RegisterBody registerBody}) async {
    return await authByFirebase.createUserWithEmailAndPass(
        registerBody: registerBody);
  }

  @override
  Future<UserCredential> googleSignIn()async {
    return await authByFirebase.googleSignIn();
  }

  @override
  Future<UserCredential> facebookSignIn() async{
    return await authByFirebase.facebookSignIn();
  }
}
