import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fsociety/core/errors/failures.dart';
import 'package:fsociety/features/addpost/data/models/post_model.dart';
import 'package:fsociety/features/addpost/domain/repositories/add_post_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/add_post_remote_data_source.dart';

class AddPostRepositoryImpl extends AddPostRepository {
  final AddPostRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AddPostRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>>
      createPostImg({required PostModel postModel}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.createPostImg( postModel: postModel);
        return right(response);
      } on FirebaseException catch (e) {
        print(e.message.toString());
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadPostImg(
      {required File file}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.uploadPostImg(file: file);
        final downLoadUrl = await response.ref.getDownloadURL();
        return right(downLoadUrl);
      } on FirebaseException catch (e) {
        print(e.message.toString());
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
