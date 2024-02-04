import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/features/messages/domain/repositories/messages_repository.dart';

import '../../../../core/errors/failures.dart';

class SendMessageUseCase {
  final MessagesRepository messagesRepository;

  SendMessageUseCase({required this.messagesRepository});

  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> call(
      receiverId, content , lastMsgModel) async {
    return await messagesRepository.sendMessage(
        receiverId: receiverId, content: content, lastMsgModel: lastMsgModel);
  }
}
