import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fsociety/core/firebase/storage/storage.dart';
import 'package:fsociety/features/layout/data/models/comment_model.dart';

import '../../../../../core/firebase/firebase_store/firebase_firestore.dart';

abstract class FeedsRemoteDataSource {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData();

  Future<QuerySnapshot<Map<String, dynamic>>> getAllPosts();

  Future<void> postLike(postId);

  Future<void> disLike(postId);

  Future<void> savePost(postId,String postImg);

  Future<void> unSavePost(postId);

  Future<DocumentSnapshot<Map<String, dynamic>>> checkLike(String postId);
  Future<DocumentSnapshot<Map<String, dynamic>>> checkSaved(String postId);

  Future<DocumentReference<Map<String, dynamic>>> addComment(
      String postId, CommentModel model);

  Future<QuerySnapshot<Map<String, dynamic>>> getComments(String postsId);
   Future<void> deletePost(String postId);




}

class FeedsRemoteDataSourceImpl implements FeedsRemoteDataSource {
  final StorageByFirebase storageByFirebase;
  final FStorage fStorage;

  FeedsRemoteDataSourceImpl( {required this.storageByFirebase,required this.fStorage,});

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    return await storageByFirebase.getUserData();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllPosts() async {
    return await storageByFirebase.getAllPosts();
  }

  @override
  Future<void> postLike(postId) async {
    return await storageByFirebase.postLike(postId);
  }

  @override
  Future<void> disLike(postId) async {
    return await storageByFirebase.disLike(postId);
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> checkLike(
      String postId) async {
    return await storageByFirebase.checkLike(postId);
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> addComment(
      String postId, CommentModel model) async {
    return await storageByFirebase.addComment(postId, model);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getComments(
      String postsId) async {
    return await storageByFirebase.getComments(postsId);
  }

  @override
  Future<void> savePost(postId,String postImg) async {
    return await storageByFirebase.savePost(postId,postImg);
  }

  @override
  Future<void> unSavePost(postId) async {
    return await storageByFirebase.unSavePost(postId);
  }

  @override
  Future<void> deletePost(String postId)async {
    return await storageByFirebase.deletePost(postId);
  }



  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> checkSaved(String postId)async {
    return await storageByFirebase.checkSaved(postId);
  }



}
