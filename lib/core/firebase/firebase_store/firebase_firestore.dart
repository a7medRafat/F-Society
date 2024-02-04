import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fsociety/core/collections/collections.dart';
import 'package:fsociety/core/shared_preferances/cache_helper.dart';
import 'package:fsociety/features/addpost/data/models/post_model.dart';
import 'package:fsociety/features/layout/data/models/comment_model.dart';
import 'package:fsociety/features/messages/data/models/last_message_model.dart';
import 'package:fsociety/features/stories/data/models/story_model.dart';
import '../../../features/authentication/data/models/current_user_model.dart';
import '../../../features/favourites/data/models/notification_model.dart';
import '../../../features/messages/data/models/message_model.dart';
import '../../../features/usersprofile/data/models/followers_model.dart';
import '../../../features/usersprofile/data/models/following_model.dart';
import '../../local_storage/hive_keys.dart';
import '../../local_storage/user_storage.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

abstract class StorageByFirebase {
  Future<void> addUserToFireStore({required CurrentUser currentUser});

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData();

  Future<CurrentUser> getCurrentUser({required String uid});

  Future<QuerySnapshot<Map<String, dynamic>>> getAllPosts();

  Future<QuerySnapshot<Map<String, dynamic>>> getAllStories();

  Future<DocumentReference<Map<String, dynamic>>> createPostImg(
      {required PostModel postModel});

  Future<DocumentReference<Map<String, dynamic>>> createStoryImg(
      {required StoryModel storyModel});

  Future<void> postLike(postId);

  Future<void> disLike(postId);

  Future<void> savePost(postId, String postImg);

  Future<void> unSavePost(postId);

  Future<DocumentSnapshot<Map<String, dynamic>>> checkLike(String postId);

  Future<DocumentSnapshot<Map<String, dynamic>>> checkSaved(String postId);

  Future<DocumentReference<Map<String, dynamic>>> addComment(
      String postId, CommentModel model);

  Future<QuerySnapshot<Map<String, dynamic>>> getComments(String postsId);

  Future<void> deletePost(String postId);

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers();

  Future<DocumentReference<Map<String, dynamic>>> sendMessage(
      {required String receiverId,
      required String content,
      required LastMsgModel lastMsgModel});

  Future<List<MessageModel>> getMessages({required String receiverId});

  Future<List<String>> friendGallery(String friendUid);

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

  Future<DocumentSnapshot<Map<String, dynamic>>> checkFriendFollow(
      String friendId);

  Future<DocumentReference<Map<String, dynamic>>> addNotificationToFb(
      {required String uid, required NotificationModel notificationModel});
}

class StorageByFirebaseImpl implements StorageByFirebase {
  final users = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addUserToFireStore({required CurrentUser currentUser}) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .set(currentUser.toJson());
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uid'))
        .get();
  }

  @override
  Future<CurrentUser> getCurrentUser({required String uid}) async {
    final result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    CurrentUser user = CurrentUser.fromJson(result.data()!);
    return user;
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> createPostImg(
      {required PostModel postModel}) async {
    return await Collections().posts
        .add(postModel.toJson());
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllPosts() async {
    return await Collections().posts
        .orderBy('dateTime')
        .get();
  }

  @override
  Future<void> postLike(postId) async {
    return await Collections().posts
        .doc(postId)
        .collection('likes')
        .doc(CacheHelper.getData(key: 'uid'))
        .set({'like': true});
  }

  @override
  Future<void> disLike(postId) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(CacheHelper.getData(key: 'uid'))
        .delete();
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> checkLike(
      String postId) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(CacheHelper.getData(key: 'uid'))
        .get();
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> addComment(
      String postId, CommentModel model) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap());
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getComments(
      String postsId) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(postsId)
        .collection('comments')
        .get();
  }

  @override
  Future<void> savePost(postId, String postImg) async {
    return await Collections().posts
        .doc(postId)
        .collection('saved')
        .doc(CacheHelper.getData(key: 'uid'))
        .set({
      'saved': true,
      'savedPost': postImg,
    });
  }

  @override
  Future<void> unSavePost(postId) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('saved')
        .doc(CacheHelper.getData(key: 'uid'))
        .delete();
  }

  @override
  Future<void> deletePost(String postId) async {
    DocumentSnapshot post =
        await FirebaseFirestore.instance.collection('posts').doc(postId).get();
    post.reference.delete();
    QuerySnapshot likes = await post.reference.collection('likes').get();
    for (var e in likes.docs) {
      e.reference.delete();
    }
    QuerySnapshot comments = await post.reference.collection('comments').get();
    for (var e in comments.docs) {
      e.reference.delete();
    }
    QuerySnapshot saved = await post.reference.collection('saved').get();
    for (var e in saved.docs) {
      e.reference.delete();
    }
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> createStoryImg(
      {required StoryModel storyModel}) async {
    return await FirebaseFirestore.instance
        .collection('stories')
        .add(storyModel.toMap());
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> checkSaved(
      String postId) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('saved')
        .doc(CacheHelper.getData(key: 'uid'))
        .get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllStories() async {
    final allStories =
        await FirebaseFirestore.instance.collection('stories').get();
    return allStories;
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    final users = await FirebaseFirestore.instance.collection('users').get();
    return users;
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> sendMessage(
      {required String receiverId,
      required String content,
      required LastMsgModel lastMsgModel}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    MessageModel messageModel = MessageModel(
        dateTime: DateTime.now().toString(),
        senderId: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid,
        receiverId: receiverId,
        content: content);

    final message = await Collections().chatCol
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toJson());

    await users
        .doc(receiverId)
        .collection('chats')
        .doc(di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid)
        .collection('messages')
        .add(messageModel.toJson());

    await Collections().chatCol
        .doc(receiverId)
        .set(lastMsgModel.toJson());

    LastMsgModel last = LastMsgModel(
        name: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name!,
        image: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.image!,
        lastMessage: content,
        receiverId:
            di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid!);

    await users
        .doc(receiverId)
        .collection('chats')
        .doc(di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid)
        .set(last.toJson());

    return message;
  }

  List<MessageModel> messages = [];

  @override
  Future<List<MessageModel>> getMessages({required String receiverId}) async {
    messages = [];
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      for (var e in event.docs) {
        messages.add(MessageModel.fromJson(e.data()));
      }
    });
    return messages;
  }

  @override
  Future<List<String>> friendGallery(friendUid) async {
    List<String> list = [];
    final posts = await FirebaseFirestore.instance.collection('posts').get();
    for (var e in posts.docs) {
      if (e.data()['uid'] == friendUid) {
        list.add(e.data()['postImage']);
      }
    }
    return list;
  }

  @override
  Future<void> follow({
    required String receiverUid,
    required String receiverName,
    required String receiverImg,
    required String receiverBio,
  }) async {
    final collectionReference = FirebaseFirestore.instance.collection('users');

    FollowingModel followingsModel = FollowingModel(
        senderUid: CacheHelper.getData(key: 'uid'),
        receiverUid: receiverUid,
        name: receiverName,
        image: receiverImg,
        bio: receiverBio);

    collectionReference
        .doc(CacheHelper.getData(key: 'uid'))
        .collection('following')
        .doc(receiverUid)
        .set(followingsModel.toMap());

    FollowersModel followersModel = FollowersModel(
        senderUid: receiverUid,
        receiverUid: CacheHelper.getData(key: 'uid'),
        name: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name,
        image: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.image,
        bio: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.bio);

    collectionReference
        .doc(receiverUid)
        .collection('followers')
        .doc(CacheHelper.getData(key: 'uid'))
        .set(followersModel.toMap());
  }

  @override
  Future<void> unfollow({required String receiverUid}) async {
    users
        .doc(CacheHelper.getData(key: 'uid'))
        .collection('following')
        .doc(receiverUid)
        .delete();

    users
        .doc(receiverUid)
        .collection('followers')
        .doc(CacheHelper.getData(key: 'uid'))
        .delete();
  }

  @override
  Future<List<FollowersModel>> getFriendFollowers(
      {required String receiverUid}) async {
    List<FollowersModel> list = [];
    final followersCol =
        await users.doc(receiverUid).collection('followers').get();
    for (var e in followersCol.docs) {
      list.add(FollowersModel.fromJson(e.data()));
    }
    return list;
  }

  @override
  Future<List<FollowingModel>> getFriendFollowing(
      {required String receiverUid}) async {
    List<FollowingModel> list = [];
    final followingsCol =
        await users.doc(receiverUid).collection('following').get();
    for (var e in followingsCol.docs) {
      list.add(FollowingModel.fromJson(e.data()));
    }
    return list;
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> checkFriendFollow(
      String friendId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uid'))
        .collection('following')
        .doc(friendId)
        .get();
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> addNotificationToFb(
      {required String uid, required NotificationModel notificationModel})async {
    return await Collections().users
        .doc(uid)
        .collection('notifications')
        .add(notificationModel.toMap());
  }
}
