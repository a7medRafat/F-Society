import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/features/messages/data/models/last_message_model.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/get_all_users.dart';
import '../../data/models/message_model.dart';

abstract class MessagesRepository {
  Future<Either<Failure, List<AllUsersModel>>> getAllUsers();

  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> sendMessage(
      {required String receiverId,
      required LastMsgModel lastMsgModel,
      required String content});

  Future<Either<Failure, List<MessageModel>>> getMessages(
      {required String receiverId});

  Future<Either<Failure, List<AllUsersModel>>> getContacts();
}
