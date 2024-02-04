import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/favourites_repository.dart';

class AddNotificationToFbUseCase {
  final FavouritesRepository favouritesRepository;

  AddNotificationToFbUseCase({required this.favouritesRepository});

  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> call(
      uid, notificationModel) async {
    return await favouritesRepository.addNotificationToFb(
        uid: uid, notificationModel: notificationModel);
  }
}
