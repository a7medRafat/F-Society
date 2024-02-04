import 'package:dartz/dartz.dart';
import 'package:fsociety/features/messages/domain/repositories/messages_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/message_model.dart';

class GetMessagesUseCase {
  final MessagesRepository messagesRepository;

  GetMessagesUseCase({required this.messagesRepository});

  Future<Either<Failure, List<MessageModel>>> call(
      receiverId) async {
    return await messagesRepository.getMessages(receiverId: receiverId);
  }
}
