import 'package:dartz/dartz.dart';
import 'package:fsociety/features/messages/domain/repositories/messages_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/get_all_users.dart';

class GetAllUsersUseCase{
  final MessagesRepository messagesRepository;

  GetAllUsersUseCase({required this.messagesRepository});

  Future<Either<Failure, List<AllUsersModel>>> call()async{
    return await messagesRepository.getAllUsers();
  }
}