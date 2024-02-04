import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fsociety/core/firebase/firebase_store/firebase_firestore.dart';

import '../../models/notification_model.dart';

abstract class FavouritesRemoteDataSource {
  Future<DocumentReference<Map<String, dynamic>>> addNotificationToFb(
      {required String uid, required NotificationModel notificationModel});
}

class FavouritesRemoteDataSourceImpl extends FavouritesRemoteDataSource {
  FavouritesRemoteDataSourceImpl({required this.storageByFirebase});

  final StorageByFirebase storageByFirebase;

  @override
  Future<DocumentReference<Map<String, dynamic>>> addNotificationToFb(
      {required String uid,
      required NotificationModel notificationModel}) async {
    return await storageByFirebase.addNotificationToFb(
        uid: uid, notificationModel: notificationModel);
  }
}
