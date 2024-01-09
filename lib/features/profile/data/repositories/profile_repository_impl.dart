import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fsociety/core/errors/failures.dart';
import 'package:fsociety/features/profile/domain/repositories/profile_repository.dart';
import '../../../../core/network/network_info.dart';
import '../../../layout/data/datasources/remote/feeds_remote_data_source.dart';
import '../datasources/remote/profile_remote_data_source.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final FeedsRemoteDataSource feedsRemoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl(
      {required this.remoteDataSource,
      required this.networkInfo,
      required this.feedsRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> updateUser(
      {required Map<String, dynamic> map}) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateUser(map: map);
        return right(unit);
      } on FirebaseException catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfileImg(
      {required File file}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.uploadProfileImg(file: file);
        final downLoadUrl = await response.ref.getDownloadURL();
        return right(downLoadUrl);
      } on FirebaseException catch (e) {
        if(e.code == 'object-not-found'){
        }
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }
}
