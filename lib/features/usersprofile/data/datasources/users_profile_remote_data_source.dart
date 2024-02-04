import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fsociety/features/usersprofile/data/models/followers_model.dart';
import 'package:fsociety/features/usersprofile/data/models/following_model.dart';

import '../../../../core/firebase/firebase_store/firebase_firestore.dart';

abstract class FriendProfileRemoteDataSource {
  Future<List<String>> friendGallery(friendUid);

  Future<void> follow({
    required String receiverUid,
    required String receiverName,
    required String receiverImg,
    required String receiverBio,
  });

  Future<void> unfollow({required String receiverUid});

  Future<List<FollowersModel>> getFriendFollowers(
      {required String receiverUid});

  Future<List<FollowingModel>> getFriendFollowing(
      {required String receiverUid});

  Future<DocumentSnapshot<Map<String, dynamic>>> checkFriendFollow(String friendId);
}

class FriendProfileRemoteDataSourceImpl
    implements FriendProfileRemoteDataSource {
  final StorageByFirebase storageByFirebase;

  FriendProfileRemoteDataSourceImpl({required this.storageByFirebase});

  @override
  Future<List<String>> friendGallery(friendUid) async {
    return storageByFirebase.friendGallery(friendUid);
  }

  @override
  Future<void> follow({
    required String receiverUid,
    required String receiverName,
    required String receiverImg,
    required String receiverBio,
  }) async {
    return await storageByFirebase.follow(
        receiverUid: receiverUid,
        receiverName: receiverName,
        receiverImg: receiverImg,
        receiverBio: receiverBio);
  }

  @override
  Future<void> unfollow({required String receiverUid}) async {
    return await storageByFirebase.unfollow(receiverUid: receiverUid);
  }

  @override
  Future<List<FollowersModel>> getFriendFollowers(
      {required String receiverUid}) async {
    return await storageByFirebase.getFriendFollowers(receiverUid: receiverUid);
  }

  @override
  Future<List<FollowingModel>> getFriendFollowing(
      {required String receiverUid}) async {
    return await storageByFirebase.getFriendFollowing(receiverUid: receiverUid);
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> checkFriendFollow(String friendId) async {
    return await storageByFirebase.checkFriendFollow(friendId);
  }
}
