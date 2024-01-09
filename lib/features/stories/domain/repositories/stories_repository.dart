import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/story_model.dart';

abstract class StoriesRepository {

  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> createStoryImg({required StoryModel storyModel});

  Future<Either<Failure, String>> uploadStoryImg({required File file});

  Future<Either<Failure, QuerySnapshot<Map<String, dynamic>>>> getAllStories();
}
