import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fsociety/features/addpost/data/models/post_model.dart';

import '../../../../core/firebase/firebase_store/firebase_firestore.dart';
import '../../../../core/firebase/storage/storage.dart';

abstract class AddPostRemoteDataSource {
  UploadTask uploadPostImg({required File file});

  Future<DocumentReference<Map<String, dynamic>>> createPostImg(
      {required PostModel postModel});
}

class AddPostRemoteDataSourceImpl extends AddPostRemoteDataSource {
  final FStorage fStorage;
  final StorageByFirebase firebase;

  AddPostRemoteDataSourceImpl({required this.fStorage, required this.firebase});

  @override
  UploadTask uploadPostImg({required File file}) {
    return fStorage.uploadPostImg(file: file);
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> createPostImg(
      {required PostModel postModel}) {
    return firebase.createPostImg(postModel: postModel);
  }
}
