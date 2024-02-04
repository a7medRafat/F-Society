import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/core/errors/failures.dart';
import 'package:fsociety/features/usersprofile/data/models/followers_model.dart';
import 'package:fsociety/features/usersprofile/data/models/following_model.dart';
import 'package:fsociety/features/usersprofile/domain/repositories/users_profile_repository.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/users_profile_remote_data_source.dart';

class FriendProfileRepositoryImpl extends FriendProfileRepository {
  final NetworkInfo networkInfo;
  final FriendProfileRemoteDataSource profileRemoteDataSource;

  FriendProfileRepositoryImpl(
      {required this.networkInfo, required this.profileRemoteDataSource});

  @override
  Future<Either<Failure, List<String>>> friendGallery(friendUid) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await profileRemoteDataSource.friendGallery(friendUid);
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
  Future<Either<Failure, void>> follow({
    required String receiverUid,
    required String receiverName,
    required String receiverImg,
    required String receiverBio,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await profileRemoteDataSource.follow(
            receiverUid: receiverUid,
            receiverName: receiverName,
            receiverImg: receiverImg,
            receiverBio: receiverBio);
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
  Future<Either<Failure, void>> unfollow({required String receiverUid}) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await profileRemoteDataSource.unfollow(receiverUid: receiverUid);
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
  Future<Either<Failure, List<FollowersModel>>> getFriendFollowers(
      {required String friendUid}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await profileRemoteDataSource.getFriendFollowers(
            receiverUid: friendUid);
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
  Future<Either<Failure, List<FollowingModel>>> getFriendFollowing(
      {required String friendUid}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await profileRemoteDataSource.getFriendFollowing(
            receiverUid: friendUid);
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
  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>>
      checkFriendFollow({required String friendId}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await profileRemoteDataSource.checkFriendFollow(friendId);
        return right(response);
      } on ServerException catch (e) {
        print(e.toString());
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }
}
