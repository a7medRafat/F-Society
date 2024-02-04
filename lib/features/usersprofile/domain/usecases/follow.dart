import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/users_profile_repository.dart';

class FollowUseCase {
  final FriendProfileRepository friendProfileRepository;

  FollowUseCase({required this.friendProfileRepository});

  Future<Either<Failure, void>> call(
      {required String receiverUid,
      required String receiverName,
      required String receiverImg,
        required String receiverBio,
      }) async {
    return await friendProfileRepository.follow(
        receiverUid: receiverUid,
        receiverName: receiverName,
        receiverImg: receiverImg,
      receiverBio: receiverBio
    );
  }
}
