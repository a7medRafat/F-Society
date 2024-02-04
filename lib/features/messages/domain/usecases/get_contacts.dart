import 'package:dartz/dartz.dart';
import 'package:fsociety/features/messages/domain/repositories/messages_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/get_all_users.dart';

class GetContactsUseCase{
  final MessagesRepository messagesRepository;

  GetContactsUseCase({required this.messagesRepository});

  Future<Either<Failure, List<AllUsersModel>>> call()async{
    return await messagesRepository.getContacts();
  }
}