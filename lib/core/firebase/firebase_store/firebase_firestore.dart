import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fsociety/core/shared_preferances/cache_helper.dart';
import 'package:fsociety/features/addpost/data/models/post_model.dart';
import 'package:fsociety/features/layout/data/models/comment_model.dart';
import 'package:fsociety/features/stories/data/models/story_model.dart';

import '../../../features/authentication/data/models/current_user_model.dart';

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
}

class StorageByFirebaseImpl implements StorageByFirebase {
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
    return await FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toJson());
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllPosts() async {
    return await FirebaseFirestore.instance
        .collection("posts")
        .orderBy('dateTime')
        .get();
  }

  @override
  Future<void> postLike(postId) async {
    return await FirebaseFirestore.instance
        .collection('posts')
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
    return await FirebaseFirestore.instance
        .collection('posts')
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
  Future<QuerySnapshot<Map<String, dynamic>>> getAllStories()async {
    final allStories = await FirebaseFirestore.instance.collection('stories').get();
    return allStories;
  }
}
