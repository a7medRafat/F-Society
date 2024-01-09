import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/core/errors/failures.dart';
import '../../data/models/post_model.dart';

abstract class AddPostRepository {
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>>
      createPostImg({required PostModel postModel});

  Future<Either<Failure, String>> uploadPostImg({required File file});
}
