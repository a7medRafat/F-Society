import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/core/errors/exceptions.dart';
import 'package:fsociety/core/errors/failures.dart';
import 'package:fsociety/features/authentication/data/models/current_user_model.dart';
import 'package:fsociety/features/layout/data/models/comment_model.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/feeds_repository.dart';
import '../datasources/local/feeds_local_data_source.dart';
import '../datasources/remote/feeds_remote_data_source.dart';

class FeedsRepositoryImpl extends FeedsRepository {
  final NetworkInfo networkInfo;
  final FeedsRemoteDataSource feedsRemoteDataSource;
  final FeedsLocalDataSource feedsLocalDataSource;

  FeedsRepositoryImpl(
      {required this.networkInfo,
      required this.feedsRemoteDataSource,
      required this.feedsLocalDataSource});

  @override
  Future<Either<Failure, CurrentUser>> getCurrentUserData() async {
    if (await networkInfo.isConnected) {
      try {
        final snapShoot = await feedsRemoteDataSource.getUserData();
        final snapShot2Map = snapShoot.data();
        final response = CurrentUser.fromJson(snapShot2Map!);
        feedsLocalDataSource.cachesData(response);
        return right(response);
      } on FirebaseException catch (e) {
        print(e.code);
        return left(ServerFailure());
      }
    } else {
      try {
        final localData = await feedsLocalDataSource.getCachedData();
        return right(localData);
      } on EmptyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, QuerySnapshot<Map<String, dynamic>>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await feedsRemoteDataSource.getAllPosts();
        return right(response);
      } on FirebaseException catch (e) {
        return left(MyServerFailure(error: e));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, void>> postLike(postId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await feedsRemoteDataSource.postLike(postId);
        return right(response);
      } on ServerException catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> disLike(postId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await feedsRemoteDataSource.disLike(postId);
        return right(response);
      } on ServerException catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>> checkLike(
      String postId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await feedsRemoteDataSource.checkLike(postId);
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
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> addComment(
      String postId, CommentModel model) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await feedsRemoteDataSource.addComment(postId, model);
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
  Future<Either<Failure, QuerySnapshot<Map<String, dynamic>>>> getComments(
      String postsId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await feedsRemoteDataSource.getComments(postsId);
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
  Future<Either<Failure, void>> savePost(postId, String postImg) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await feedsRemoteDataSource.savePost(postId, postImg);
        return right(response);
      } on ServerException catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unSavePost(postId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await feedsRemoteDataSource.unSavePost(postId);
        return right(response);
      } on ServerException catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await feedsRemoteDataSource.deletePost(postId);
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
  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>> checkSaved(String postId)async {
    if (await networkInfo.isConnected) {
      try {
        final response = await feedsRemoteDataSource.checkSaved(postId);
        return right(response);
      } on FirebaseException catch (e) {
        print('==>> ${e.toString()}');
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }



}
