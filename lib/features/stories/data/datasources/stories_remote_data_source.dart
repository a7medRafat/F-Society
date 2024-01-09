import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/firebase/firebase_store/firebase_firestore.dart';
import '../../../../core/firebase/storage/storage.dart';
import '../models/story_model.dart';

abstract class StoriesRemoteDataSource {
  UploadTask uploadStoryImg({required File file});

  Future<DocumentReference<Map<String, dynamic>>> createStoryImg(
      {required StoryModel storyModel});

  Future<QuerySnapshot<Map<String, dynamic>>> getAllStories();
}

class StoriesRemoteDataSourceImpl implements StoriesRemoteDataSource {
  final StorageByFirebase storageByFirebase;
  final FStorage fStorage;
  StoriesRemoteDataSourceImpl({required this.storageByFirebase,required this.fStorage});

  @override
  Future<DocumentReference<Map<String, dynamic>>> createStoryImg({required StoryModel storyModel})async {
    return await storageByFirebase.createStoryImg(storyModel: storyModel);
  }

  @override
  UploadTask uploadStoryImg({required File file}) {
    return fStorage.uploadStoryImg(file: file);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllStories()async {
    return await storageByFirebase.getAllStories();
  }
}
