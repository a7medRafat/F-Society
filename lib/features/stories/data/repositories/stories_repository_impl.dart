import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fsociety/core/errors/failures.dart';
import 'package:fsociety/features/stories/data/datasources/stories_remote_data_source.dart';
import 'package:fsociety/features/stories/data/models/story_model.dart';
import 'package:fsociety/features/stories/domain/repositories/stories_repository.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';

class StoriesRepositoryImpl implements StoriesRepository {
  final NetworkInfo networkInfo;
  final StoriesRemoteDataSource storiesRemoteDataSource;

  StoriesRepositoryImpl(
      {required this.networkInfo, required this.storiesRemoteDataSource});

  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>>
      createStoryImg({required StoryModel storyModel}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await storiesRemoteDataSource.createStoryImg(
            storyModel: storyModel);
        return right(response);
      } on ServerException catch (e) {
        print(e.toString());
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadStoryImg(
      {required File file}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await storiesRemoteDataSource.uploadStoryImg(file: file);
        final downloadUrl =await response.ref.getDownloadURL();
        return right(downloadUrl);
      } on FirebaseException catch (e) {
        print('==>> ${e.toString()}');
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, QuerySnapshot<Map<String, dynamic>>>> getAllStories()async {
    if (await networkInfo.isConnected) {
      try {
        final response = await storiesRemoteDataSource.getAllStories();
        return right(response);
      } on FirebaseException catch (e) {
        print(e.toString());
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }
}
