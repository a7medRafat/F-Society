import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/users_profile_repository.dart';

class UnfollowUseCase {
  final FriendProfileRepository friendProfileRepository;

  UnfollowUseCase({required this.friendProfileRepository});

  Future<Either<Failure, void>> call({required String receiverUid}) async {
    return await friendProfileRepository.unfollow(receiverUid: receiverUid);
  }
}
