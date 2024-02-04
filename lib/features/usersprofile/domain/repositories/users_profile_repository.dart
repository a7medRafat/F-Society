import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/core/errors/failures.dart';
import 'package:fsociety/features/usersprofile/data/models/followers_model.dart';
import 'package:fsociety/features/usersprofile/data/models/following_model.dart';

abstract class FriendProfileRepository {
  Future<Either<Failure, List<String>>> friendGallery(friendUid);

  Future<Either<Failure, void>> follow(
      {required String receiverUid,
      required String receiverName,
      required String receiverImg,
        required String receiverBio,
      });

  Future<Either<Failure, void>> unfollow({required String receiverUid});

  Future<Either<Failure, List<FollowersModel>>> getFriendFollowers(
      {required String friendUid});

  Future<Either<Failure, List<FollowingModel>>> getFriendFollowing(
      {required String friendUid});

  Future<Either<Failure,DocumentSnapshot<Map<String, dynamic>>>> checkFriendFollow({required String friendId});
}
