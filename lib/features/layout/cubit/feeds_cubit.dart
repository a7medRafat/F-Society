// ignore: depend_on_referenced_packages
import 'package:fsociety/core/failures_message/failures_messages.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/core/notification/send_fcm.dart';
import 'package:fsociety/features/layout/domain/usecases/check_saved.dart';
import 'package:fsociety/features/layout/domain/usecases/delete_post.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/features/layout/domain/usecases/add_comment.dart';
import 'package:fsociety/features/layout/domain/usecases/get_all_posts.dart';
import 'package:fsociety/features/layout/domain/usecases/get_comments.dart';
import 'package:fsociety/features/layout/domain/usecases/post_dislike.dart';
import 'package:fsociety/features/layout/domain/usecases/post_like.dart';
import 'package:fsociety/features/layout/domain/usecases/save_post.dart';
import 'package:fsociety/features/layout/domain/usecases/unsave_post.dart';
import '../../addpost/data/models/post_model.dart';
import '../../authentication/data/models/current_user_model.dart';
import '../../favourites/cubit/favourites_cubit.dart';
import '../../favourites/data/models/notification_model.dart';
import '../data/models/comment_model.dart';
import '../domain/usecases/check_like.dart';
import '../domain/usecases/get_user_data.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

part 'feeds_state.dart';

class FeedsCubit extends Cubit<FeedsState> {
  final GetUserDataUseCase getUserDataUseCase;
  final GetAllPostsUseCase getAllPostsUseCase;
  final PostLikeUseCase postLikeUseCase;
  final DisLikeUseCase disLikeUseCase;
  final CheckLikeUseCase checkLikeUseCase;
  final AddCommentUseCase addCommentUseCase;
  final GetCommentsUseCase getCommentsUseCase;
  final SavePostUseCase savePostUseCase;
  final UnSavePostUseCase unSavePostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final CheckSavedUseCase checkSavedUseCase;

  FeedsCubit({
    required this.getUserDataUseCase,
    required this.getAllPostsUseCase,
    required this.postLikeUseCase,
    required this.disLikeUseCase,
    required this.checkLikeUseCase,
    required this.addCommentUseCase,
    required this.getCommentsUseCase,
    required this.savePostUseCase,
    required this.unSavePostUseCase,
    required this.deletePostUseCase,
    required this.checkSavedUseCase,
  }) : super(FeedsInitial());

  static FeedsCubit get(context) => BlocProvider.of(context);

  final TextEditingController commentController = TextEditingController();

  Future<void> getCurrentUserData() async {
    emit(FeedsLoadingState());
    final failureOrSuccess = await getUserDataUseCase.call();
    failureOrSuccess
        .fold((failure) => emit(FeedsErrorState(msg: failure.getMessage())),
            (currentUser) {
      di
          .sl<UserStorage>()
          .saveData(id: HiveKeys.currentUser, data: currentUser);
      emit(FeedsSuccessState(currentUser: currentUser));
    });
  }

  List<String> postId = [];
  List<int> likes = [];
  int myLikes = 0;
  List<int> commentsNum = [];
  List<String> colors = [];
  List<Color> commentColors = [];
  List<Color> savedColors = [];
  List<PostModel> posts = [];
  List<int> saved = [];
  List<String> postsImage = [];

  increaseLikes() {
    myLikes++;
    emit(MyLikeIncreaseState());
  }

  decreaseLikes() {
    myLikes--;
    emit(MyLikeDecreaseState());
  }

  int postsLength = 0;

  Future<void> getAllPosts() async {
    posts = [];
    postId = [];
    colors = [];
    likes = [];
    commentsNum = [];
    commentColors = [];
    savedColors = [];
    saved = [];
    postsImage = [];
    myLikes = 0;

    if (posts.isEmpty) {
      emit(GetAllPostsLoadingState());
      final failureOrSuccess = await getAllPostsUseCase.call();
      failureOrSuccess.fold((failure) => emit(GetAllPostsErrorState()),
          (success) async {
        postsLength = success.docs.length;
        for (var postDocs in success.docs) {
          final commentDocs =
              await postDocs.reference.collection('comments').get();
          final likesDocs = await postDocs.reference.collection('likes').get();
          final savedDocs = await postDocs.reference.collection('saved').get();

          bool savedFound = false;
          if (savedDocs.docs.isEmpty) {
            savedColors.add(Colors.white);
          } else {
            for (var e in savedDocs.docs) {
              if (e.id ==
                  di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid) {
                savedColors.add(Colors.deepPurple);
                savedFound = true;
              }
              if (savedFound == true) {
                break;
              }
            }
            if (savedFound == false) {
              savedColors.add(Colors.white);
            }
          }

          //// my posts ////
          // if (postDocs.data()['uid'] ==
          //     di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid) {
          //   myLikes += likesDocs.docs.length;
          // }

          //// comments color ////
          bool commentFound = false;
          if (commentDocs.docs.isEmpty) {
            commentColors.add(Colors.white);
          } else {
            for (var e in commentDocs.docs) {
              if (e.data()['userId'] ==
                  di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid) {
                commentColors.add(Colors.amber);
                commentFound = true;
              }
              if (commentFound == true) {
                break;
              }
            }
            if (commentFound == false) {
              commentColors.add(Colors.white);
            }
          }

          bool found = false;
          if (likesDocs.docs.isEmpty) {
            colors.add('white');
          } else {
            for (var e in likesDocs.docs) {
              if (di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid ==
                  e.id) {
                colors.add('red');
                found = true;
              }
              if (found == true) {
                break;
              }
            }
            if (found == false) {
              colors.add('grey');
            }
          }

          //// lists ////

          likes.add(likesDocs.docs.length);
          saved.add(savedDocs.docs.length);
          commentsNum.add(commentDocs.docs.length);
          postId.add(postDocs.id);
          postsImage.add(postDocs.data()['postImage']);
          posts.add(PostModel.fromJson(postDocs.data()));
          if (success.docs.length == posts.length) {
            emit(GetAllPostsSuccessState());
          }
        }
      });
    }
  }

  //// post like ////
  void postLike(String postId, int index) async {
    likes[index]++;
    colors[index] = 'red';
    emit(PostLikeLoadingState());
    final failureOrSuccess = await postLikeUseCase.call(postId);
    failureOrSuccess.fold((failure) {
      likes[index]--;
      colors[index] = 'white';
      emit(PostLikeErrorState(error: failureMessage(failure)));
    }, (success) {
      NotificationModel notificationModel = NotificationModel(
        title: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name,
        body: 'liked your post',
        bio: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.bio,
        senderUid: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid,
        image: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.image,
        receiverUid: posts[index].uid!,
        postId: postId,
        type: 'like',
        fcmToken: posts[index].deviceToken!,
      );
      if (posts[index].uid! !=
          di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid!) {
        Api().sendFcm(
            title:
                di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name!,
            body: 'liked your post',
            fcmToken: posts[index].deviceToken!,
            type: 'follow',
            uid: posts[index].uid!);
        di.sl<FavouritesCubit>().addNotificationToFb(
            uid: posts[index].uid!, notificationModel: notificationModel);
      }

      if (posts[index].uid ==
          di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid) {
        increaseLikes();
      }
      emit(PostLikeSuccessState());
    });
  }

  void disLike(String postId, int index) async {
    emit(PostDisLikeLoadingState());
    likes[index]--;
    colors[index] = 'white';
    final failureOrSuccess = await disLikeUseCase.call(postId);
    failureOrSuccess.fold((failure) {
      likes[index]++;
      colors[index] = 'red';
      emit(PostDisLikeErrorState());
    }, (success) {
      di
          .sl<FavouritesCubit>()
          .deleteLikeNotificationFromFb(uid: posts[index].uid!, postId: postId);
      if (posts[index].uid ==
          di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid) {
        decreaseLikes();
      }
      emit(PostDisLikeSuccessState());
    });
  }

  void checkLike(String postId, int index) async {
    final failureOrCheck = await checkLikeUseCase.call(postId);
    failureOrCheck.fold((failure) => emit(PostCheckLikeErrorState()),
        (success) async {
      if (success.data() == null) {
        postLike(postId, index);
      } else {
        disLike(postId, index);
      }
    });
  }

  //// post comment ////
  void addComment(
      {required String comment,
      required String postId,
      required int index}) async {
    emit(AddCommentLoadingState());
    CommentModel commentModel = CommentModel(
        comment,
        di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.image,
        di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid,
        di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name,
        DateFormat('kk:mm:a').format(DateTime.now()).toString());
    NotificationModel notificationModel = NotificationModel(
        title: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name,
        body: 'commented on your post',
        bio: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.bio,
        senderUid: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid,
        image: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.image,
        receiverUid: posts[index].uid!,
        postId: postId,
        type: 'comment',
        fcmToken: posts[index].deviceToken!);
    final failureOrAddComment =
        await addCommentUseCase.call(postId, commentModel);
    failureOrAddComment.fold((failure) => emit(AddCommentErrorState()),
        (success) {
      commentsNum[index]++;
      commentColors[index] = Colors.amber;

      Api().sendFcm(
          title: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name!,
          body: 'commented on your post',
          fcmToken: posts[index].deviceToken!,
          type: 'follow',
          uid: posts[index].uid!);

      di.sl<FavouritesCubit>().addNotificationToFb(
          uid: posts[index].uid!, notificationModel: notificationModel);
      emit(AddCommentSuccessState());
    });
  }

  List<CommentModel> comments = [];

  Future<void> getComments({required String postId}) async {
    comments = [];
    emit(GetCommentLoadingState());
    final failureOrSuccess = await getCommentsUseCase.call(postId);
    failureOrSuccess.fold((failure) => emit(GetCommentErrorState()), (success) {
      for (var e in success.docs) {
        comments.add(CommentModel.fromJson(e.data()));
        emit(GetCommentSuccessState());
      }
    });
  }

  //// delete post ////
  void deletePost(String postId) async {
    emit(DeletePostLoadingState());
    final failureOrDelete = await deletePostUseCase.call(postId);
    failureOrDelete.fold((failure) => emit(DeletePostErrorState()), (delete) {
      getAllPosts();
      emit(DeletePostSuccessState());
    });
  }

  //// save post ////
  void savePost(String postId, int index, String postImg) async {
    final failureOrSuccess = await savePostUseCase.call(postId, postImg);
    failureOrSuccess.fold((failure) => emit(SavePostErrorState()), (success) {
      saved[index]++;
      savedColors[index] = Colors.deepPurple;
      emit(SavePostSuccessState());
    });
  }

  void unSavePost(String postId, int index) async {
    final failureOrSuccess = await unSavePostUseCase.call(postId);
    failureOrSuccess.fold((failure) => emit(UnSavePostErrorState()), (success) {
      saved[index]--;
      savedColors[index] = Colors.white;
      emit(UnSavePostSuccessState());
    });
  }

  void checkSaved(String id, int index) async {
    emit(PostCheckSavedLoadingState());
    final failureOrSaved = await checkSavedUseCase.call(id);
    failureOrSaved.fold((failure) => emit(PostCheckSavedErrorState()),
        (success) {
      if (success.data() == null) {
        savePost(id, index, postsImage[index]);
        // listSaved.add(postsImage[index]);
      } else {
        unSavePost(id, index);
      }
      emit(PostCheckSavedSuccessState());
    });
  }
}
