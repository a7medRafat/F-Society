import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/notification/send_fcm.dart';
import 'package:fsociety/core/shared_preferances/cache_helper.dart';
import 'package:fsociety/features/favourites/cubit/favourites_cubit.dart';
import 'package:fsociety/features/usersprofile/data/models/followers_model.dart';
import 'package:fsociety/features/usersprofile/data/models/following_model.dart';
import 'package:fsociety/features/favourites/data/models/notification_model.dart';
import 'package:fsociety/features/usersprofile/domain/usecases/check_friend_follow.dart';
import 'package:fsociety/features/usersprofile/domain/usecases/get_friend_followers.dart';
import 'package:meta/meta.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import '../../../core/local_storage/user_storage.dart';
import '../domain/usecases/follow.dart';
import '../domain/usecases/friend_gallery.dart';
import '../domain/usecases/get_friend_following.dart';
import '../domain/usecases/unfollow.dart';

part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  final FriendGalleryUseCase friendGalleryUseCase;
  final FollowUseCase followUseCase;
  final UnfollowUseCase unfollowUseCase;
  final GetFriendFollowersUseCase getFriendFollowersUseCase;
  final GetFriendFollowingUseCase getFriendFollowingUseCase;
  final CheckFriendUseCase checkFriendUseCase;

  FriendsCubit({
    required this.friendGalleryUseCase,
    required this.followUseCase,
    required this.unfollowUseCase,
    required this.getFriendFollowersUseCase,
    required this.getFriendFollowingUseCase,
    required this.checkFriendUseCase,
  }) : super(FriendsInitial());

  static FriendsCubit get(context) => BlocProvider.of(context);

  List<String> friendGalley = [];

  Future friendGallery(String friendUid) async {
    friendGalley = [];
    // emit(FriendGalleyLoadingState());
    final failureOrSuccess = await friendGalleryUseCase.call(friendUid);
    failureOrSuccess.fold((failure) => emit(FriendGalleyErrorState()),
        (success) {
      friendGalley = success;
      // emit(FriendGalleySuccessState());
    });
  }

  void follow({
    required String receiverUid,
    required String receiverName,
    required String receiverBio,
    required String receiverImg,
    required String token,
  }) async {
    final failureOrSuccess = await followUseCase.call(
        receiverUid: receiverUid,
        receiverName: receiverName,
        receiverImg: receiverImg,
        receiverBio: receiverBio);
    failureOrSuccess.fold((failure) => emit(SendFollowErrorState()), (success) {
      print('follow');
      iFollowThisUser = true;

      Api().sendFcm(
          title: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name!,
          body: '@started following you',
          fcmToken: token,
          type: 'follow',
          uid: receiverUid);

      NotificationModel notificationModel = NotificationModel(
          title: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name,
          body: 'started following you',
          bio: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.bio,
          senderUid: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid,
          image: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.image,
          receiverUid: receiverUid,
          postId: '',
          type: 'follow', fcmToken: token);

      di.sl<FavouritesCubit>().addNotificationToFb(
          uid: receiverUid, notificationModel: notificationModel);
      // sendNotificationToFb(
      //     uid: receiverUid, notificationModel: notificationModel);

      emit(SendFollowSuccessState());
    });
  }

  unfollow({required String receiverUid}) async {
    final failureOrSuccess =
        await unfollowUseCase.call(receiverUid: receiverUid);
    failureOrSuccess.fold((failure) => emit(UnFollowErrorState()), (success) {
      print('un follow');
      di.sl<FavouritesCubit>().deleteFollowNotificationFromFb(uid: receiverUid);
      iFollowThisUser = false;
      emit(UnFollowSuccessState());
    });
  }

  List<FollowersModel> friendFollowers = [];
  List<FollowingModel> friendFollowing = [];

  Future getFriendFollowers({required String friendUid}) async {
    friendFollowers = [];
    // emit(GetFriendFollowersLoadingState());
    final failureOrSuccess = await getFriendFollowersUseCase.call(friendUid);
    failureOrSuccess.fold((failure) => emit(GetFriendFollowersErrorState()),
        (success) {
      friendFollowers = success;
      // emit(GetFriendFollowersSuccessState());
    });
  }

  Future getFriendFollowing({required String friendUid}) async {
    friendFollowing = [];
    // emit(GetFriendFollowersLoadingState());
    final failureOrSuccess = await getFriendFollowingUseCase.call(friendUid);
    failureOrSuccess.fold((failure) => emit(GetFriendFollowingErrorState()),
        (success) {
      friendFollowing = success;
      // emit(GetFriendFollowingSuccessState());
    });
  }

  bool iFollowThisUser = false;

  checkFriendFollow({
    required String receiverUid,
    required String receiverName,
    required String receiverBio,
    required String receiverImg,
    required String token,
  }) async {
    emit(CheckIsFollowLoadingState());
    final failureOrSuccess =
        await checkFriendUseCase.call(friendId: receiverUid);
    failureOrSuccess.fold((failure) => emit(CheckIsFollowErrorState()),
        (success) {
      if (success.data() == null) {
        follow(
          receiverUid: receiverUid,
          receiverName: receiverName,
          receiverBio: receiverBio,
          receiverImg: receiverImg,
          token: token,
        );
      } else {
        unfollow(receiverUid: receiverUid);
      }
      emit(CheckIsFollowSuccessState());
    });
  }

  checkingFollow({required String friendUid}) async {
    // emit(CheckIsFollowLoadingState());
    final followingCol = await FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uid'))
        .collection('following')
        .get();

    bool iFollow = false;

    if (followingCol.docs.isEmpty) {
      iFollowThisUser = false;
    } else {
      for (var e in followingCol.docs) {
        if (e.id == friendUid) {
          iFollowThisUser = true;
          iFollow = true;
        }
        if (iFollow == true) {
          break;
        }
      }
      if (iFollow == false) {
        iFollowThisUser = false;
      }
    }
    // emit(CheckingFollowSuccessState());
  }

  Future<void> getFriendData({required String friendUid}) async {
    emit(GetFriendDataLoadingState());
    await checkingFollow(friendUid: friendUid);
    await getFriendFollowing(friendUid: friendUid);
    await getFriendFollowers(friendUid: friendUid);
    await friendGallery(friendUid);
    emit(GetFriendDataSuccessState());
  }
}
