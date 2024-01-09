// ignore: depend_on_referenced_packages
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
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
import '../data/models/comment_model.dart';
import '../domain/usecases/check_like.dart';
import '../domain/usecases/get_user_data.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

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

  void getCurrentUserData() async {
    emit(FeedsLoadingState());
    final failureOrSuccess = await getUserDataUseCase.call();
    failureOrSuccess.fold((failure) => emit(FeedsErrorState(msg: 'check your internet connection')),
        (currentUser) {
          di.sl<UserStorage>().saveData(id: HiveKeys.currentUser, data: currentUser);
      emit(FeedsSuccessState(currentUser: currentUser));
    });
  }

  CurrentUser? itsUser = di.sl<UserStorage>().getData(id: HiveKeys.currentUser);


  List<String> postId = [];
  List<int> likes = [];
  List<int> commentsNum = [];
  List<String> colors = [];
  List<Color> commentColors = [];
  List<Color> savedColors = [];
  List<PostModel> posts = [];
  List<String> myPosts = [];
  List<int> saved = [];
  List<String> postsImage = [];
  List<String> savedList = [];


  
  void getAllPosts() async {
    posts = [];
    postId = [];
    colors = [];
    likes = [];
    commentsNum = [];
    commentColors = [];
    savedColors = [];
    myPosts = [];
    saved = [];
    postsImage = [];
    savedList = [];

      emit(GetAllPostsLoadingState());
      final failureOrSuccess = await getAllPostsUseCase.call();
      failureOrSuccess.fold((failure) => emit(GetAllPostsErrorState()),
          (success) async {
        for (var postDocs in success.docs) {
            postDocs.reference.collection('comments').get().then((commentDocs) {
              postDocs.reference.collection('likes').get().then((likeDocs) {
                postDocs.reference.collection('saved').get().then((savedDocs) {
                  if (savedDocs.docs.isEmpty) {
                    savedColors.add(Colors.white);
                  } else {
                    for (var e in savedDocs.docs) {
                      if (e.id == di.sl<UserStorage>()
                              .getData(id: HiveKeys.currentUser)!
                              .uid) {
                        savedList.add(e.data()['savedPost']);
                        savedColors.add(Colors.deepPurple);
                      } else {
                        savedColors.add(Colors.white);
                      }
                    }
                  }
                  // my posts
                  if (postDocs.data()['uid'] ==
                      di
                          .sl<UserStorage>()
                          .getData(id: HiveKeys.currentUser)!
                          .uid) {
                    myPosts.add(postDocs.data()['postImage']);
                  }
                  // comments color
                  if (commentDocs.docs.isEmpty) {
                    commentColors.add(Colors.white);
                  } else {
                    for (var e in commentDocs.docs) {
                      if (e.data()['userId'] ==
                          di
                              .sl<UserStorage>()
                              .getData(id: HiveKeys.currentUser)!
                              .uid) {
                        commentColors.add(Colors.amber);
                      } else {
                        commentColors.add(Colors.white);
                      }
                    }
                  }
                  // likes colors
                  bool found = false;
                  if (likeDocs.docs.isEmpty) {
                    colors.add('white');
                  } else {
                    for (var element in likeDocs.docs) {
                      if (di
                          .sl<UserStorage>()
                          .getData(id: HiveKeys.currentUser)!
                          .uid ==
                          element.id) {
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
                  saved.add(savedDocs.docs.length);
                  likes.add(likeDocs.docs.length);
                  commentsNum.add(commentDocs.docs.length);
                  postId.add(postDocs.id);
                  postsImage.add(postDocs.data()['postImage']);
                  posts.add(PostModel.fromJson(postDocs.data()));
                  if (success.docs.length == posts.length) {
                    Future.delayed(const Duration(seconds: 3));
                    emit(GetAllPostsSuccessState());
                  }
                }).catchError((error){
                  print(error.toString());
                });
              });
            });

        }
      });
  }

  void postLike(String postId, int index) async {
    emit(PostLikeLoadingState());
    final failureOrSuccess = await postLikeUseCase.call(postId);
    failureOrSuccess.fold((failure) => emit(PostLikeErrorState()), (success) {
      likes[index]++;
      colors[index] = 'red';
      emit(PostLikeSuccessState());
    });
  }

  void disLike(String postId, int index) async {
    emit(PostDisLikeLoadingState());
    final failureOrSuccess = await disLikeUseCase.call(postId);
    failureOrSuccess.fold((failure) => emit(PostDisLikeErrorState()),
        (success) {
      likes[index]--;
      colors[index] = 'white';
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

  void addComment(
      {required String comment, required String postId, index}) async {
    emit(AddCommentLoadingState());
    CommentModel commentModel = CommentModel(
        comment,
        itsUser!.image,
        itsUser!.uid,
        itsUser!.name,
        DateFormat('kk:mm:a').format(DateTime.now()).toString());
    final failureOrAddComment =
        await addCommentUseCase.call(postId, commentModel);
    failureOrAddComment.fold((failure) => emit(AddCommentErrorState()),
        (success) {
      commentsNum[index]++;
      commentColors[index] = Colors.amber;
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

  void deletePost(String postId) async {
    emit(DeletePostLoadingState());
    final failureOrDelete = await deletePostUseCase.call(postId);
    failureOrDelete.fold((failure) => emit(DeletePostErrorState()), (delete) {
      getAllPosts();
      emit(DeletePostSuccessState());
    });
  }

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
