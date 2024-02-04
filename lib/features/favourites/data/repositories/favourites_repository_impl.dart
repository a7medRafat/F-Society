import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/core/errors/failures.dart';
import 'package:fsociety/features/favourites/data/datasources/remote/favourites_remote_data_source.dart';
import 'package:fsociety/features/favourites/data/models/notification_model.dart';
import 'package:fsociety/features/favourites/domain/repositories/favourites_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';

class FavouritesRepositoryImpl extends FavouritesRepository {
  final NetworkInfo networkInfo;
  final FavouritesRemoteDataSource favouritesRemoteDataSource;

  FavouritesRepositoryImpl(this.networkInfo, this.favouritesRemoteDataSource);

  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>>
      addNotificationToFb(
          {required String uid,
          required NotificationModel notificationModel}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await favouritesRemoteDataSource.addNotificationToFb(
            uid: uid, notificationModel: notificationModel);
        return right(response);
      } on ServerException catch (e) {
        print(e.toString());
        return left(MyServerFailure(error: e));
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
