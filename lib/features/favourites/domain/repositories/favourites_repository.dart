import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/core/errors/failures.dart';

import '../../data/models/notification_model.dart';

abstract class FavouritesRepository {
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>>
      addNotificationToFb(
          {required String uid, required NotificationModel notificationModel});
}
