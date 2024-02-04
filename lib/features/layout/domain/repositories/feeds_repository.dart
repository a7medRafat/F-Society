import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/core/errors/failures.dart';
import 'package:fsociety/features/authentication/data/models/current_user_model.dart';

import '../../data/models/comment_model.dart';

abstract class FeedsRepository {

  Future<Either<Failure,CurrentUser>> getCurrentUserData();

  Future<Either<Failure,QuerySnapshot<Map<String, dynamic>>>> getAllPosts();

  Future<Either<Failure,void>> postLike(postId);

  Future<Either<Failure,void>> disLike(postId);

  Future<Either<Failure,void>> savePost(postId,String postImg);

  Future<Either<Failure,void>> unSavePost(postId);

  Future<Either<Failure,DocumentSnapshot<Map<String, dynamic>>>> checkLike(String postId);

  Future<Either<Failure,DocumentReference<Map<String, dynamic>>>> addComment(String postId, CommentModel model);

  Future<Either<Failure,QuerySnapshot<Map<String, dynamic>>>> getComments(String postsId);

  Future<Either<Failure,void>> deletePost(String postId);


  Future<Either<Failure,DocumentSnapshot<Map<String, dynamic>>>> checkSaved(String postId);



}
