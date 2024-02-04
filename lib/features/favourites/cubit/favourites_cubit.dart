import 'package:bloc/bloc.dart';
import 'package:fsociety/core/collections/collections.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/features/favourites/data/models/notification_model.dart';
import 'package:meta/meta.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

import '../domain/usecases/add_notification_to_fb.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  final AddNotificationToFbUseCase addNotificationToFbUseCase;

  FavouritesCubit({required this.addNotificationToFbUseCase})
      : super(FavouritesInitial());

  void getNotifications() {
    Collections()
        .users
        .doc(di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid)
        .collection('notifications')
        .snapshots()
        .listen((event) {});
  }

  void addNotificationToFb(
      {required String uid,
      required NotificationModel notificationModel}) async {
    final failureOrSuccess =
        await addNotificationToFbUseCase.call(uid, notificationModel);
    failureOrSuccess.fold(
      (failure) => emit(AddNotificationToFbErrorState()),
      (success) => emit(AddNotificationToFbSuccessState()),
    );
  }

  deleteFollowNotificationFromFb({required String uid}) {
    Collections()
        .users
        .doc(uid)
        .collection('notifications')
        .get()
        .then((value) {
      for (var e in value.docs) {
        if (e.data()['receiverUid'] == uid && e.data()['postId'] == '') {
          e.reference.delete();
        }
      }
    });
  }

  deleteLikeNotificationFromFb({required String uid, required String postId}) {
    Collections()
        .users
        .doc(uid)
        .collection('notifications')
        .get()
        .then((value) {
      for (var e in value.docs) {
        if (e.data()['postId'] == postId && e.data()['type'] == 'like') {
          e.reference.delete();
        }
      }
    });
  }
}
