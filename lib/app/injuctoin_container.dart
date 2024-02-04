import 'package:fsociety/core/firebase/firebase_auth/auth.dart';
import 'package:fsociety/core/firebase/firebase_store/firebase_firestore.dart';
import 'package:fsociety/core/firebase/storage/storage.dart';
import 'package:fsociety/core/local_storage/all_contacts.dart';
import 'package:fsociety/core/local_storage/local_storage.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/core/network/network_info.dart';
import 'package:fsociety/features/addpost/cubit/create_post_cubit.dart';
import 'package:fsociety/features/addpost/data/datasources/add_post_remote_data_source.dart';
import 'package:fsociety/features/addpost/data/repositories/add_post_repository_impl.dart';
import 'package:fsociety/features/addpost/domain/repositories/add_post_repository.dart';
import 'package:fsociety/features/addpost/domain/usecases/create_post_img.dart';
import 'package:fsociety/features/addpost/domain/usecases/upload_post_img.dart';
import 'package:fsociety/features/authentication/cubit/login_cubit/login_cubit.dart';
import 'package:fsociety/features/authentication/cubit/register_cubit/register_cubit.dart';
import 'package:fsociety/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:fsociety/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:fsociety/features/authentication/domain/repositories/features_repository.dart';
import 'package:fsociety/features/authentication/domain/usecases/facebook_sign_in.dart';
import 'package:fsociety/features/authentication/domain/usecases/google_sign_in.dart';
import 'package:fsociety/features/authentication/domain/usecases/user_login.dart';
import 'package:fsociety/features/authentication/domain/usecases/user_registration.dart';
import 'package:fsociety/features/favourites/cubit/favourites_cubit.dart';
import 'package:fsociety/features/favourites/data/repositories/favourites_repository_impl.dart';
import 'package:fsociety/features/favourites/domain/usecases/add_notification_to_fb.dart';
import 'package:fsociety/features/messages/cubit/messages_cubit.dart';
import 'package:fsociety/features/messages/data/datasources/local/messages_local_data_source.dart';
import 'package:fsociety/features/messages/data/datasources/remote/messages_remote_data_source.dart';
import 'package:fsociety/features/messages/data/repositories/messages_repository_impl.dart';
import 'package:fsociety/features/messages/domain/usecases/get_all_users.dart';
import 'package:fsociety/features/messages/domain/usecases/get_messages.dart';
import 'package:fsociety/features/messages/domain/usecases/send_message.dart';
import 'package:fsociety/features/stories/cubit/story_cubit.dart';
import 'package:fsociety/features/layout/domain/usecases/add_comment.dart';
import 'package:fsociety/features/layout/domain/usecases/check_saved.dart';
import 'package:fsociety/features/layout/domain/usecases/delete_post.dart';
import 'package:fsociety/features/layout/domain/usecases/get_all_posts.dart';
import 'package:fsociety/features/layout/domain/usecases/get_comments.dart';
import 'package:fsociety/features/layout/domain/usecases/post_dislike.dart';
import 'package:fsociety/features/layout/domain/usecases/post_like.dart';
import 'package:fsociety/features/layout/domain/usecases/save_post.dart';
import 'package:fsociety/features/layout/domain/usecases/unsave_post.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import 'package:fsociety/features/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:fsociety/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:fsociety/features/profile/domain/repositories/profile_repository.dart';
import 'package:fsociety/features/profile/domain/usecases/update_user.dart';
import 'package:fsociety/features/profile/domain/usecases/upload_profile_img.dart';
import 'package:fsociety/features/stories/data/datasources/stories_remote_data_source.dart';
import 'package:fsociety/features/stories/data/repositories/stories_repository_impl.dart';
import 'package:fsociety/features/stories/domain/repositories/stories_repository.dart';
import 'package:fsociety/features/stories/domain/usecases/get_all_stories.dart';
import 'package:fsociety/features/stories/domain/usecases/upload_story_img.dart';
import 'package:fsociety/features/usersprofile/cubit/friends_cubit.dart';
import 'package:fsociety/features/usersprofile/data/repositories/users_profile_repository_impl.dart';
import 'package:fsociety/features/usersprofile/domain/repositories/users_profile_repository.dart';
import 'package:fsociety/features/usersprofile/domain/usecases/check_friend_follow.dart';
import 'package:fsociety/features/usersprofile/domain/usecases/follow.dart';
import 'package:fsociety/features/usersprofile/domain/usecases/friend_gallery.dart';
import 'package:fsociety/features/usersprofile/domain/usecases/get_friend_followers.dart';
import 'package:fsociety/features/usersprofile/domain/usecases/get_friend_following.dart';
import 'package:fsociety/features/usersprofile/domain/usecases/unfollow.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../features/favourites/data/datasources/remote/favourites_remote_data_source.dart';
import '../features/favourites/domain/repositories/favourites_repository.dart';
import '../features/layout/cubit/feeds_cubit.dart';
import '../features/layout/data/datasources/local/feeds_local_data_source.dart';
import '../features/layout/data/datasources/remote/feeds_remote_data_source.dart';
import '../features/layout/data/repositories/feeds_repository_impl.dart';
import '../features/layout/domain/repositories/feeds_repository.dart';
import '../features/layout/domain/usecases/check_like.dart';
import '../features/messages/domain/repositories/messages_repository.dart';
import '../features/stories/domain/usecases/create_story_img.dart';
import '../features/layout/domain/usecases/get_user_data.dart';
import '../features/usersprofile/data/datasources/users_profile_remote_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<RegisterCubit>(
      () => RegisterCubit(userRegistrationUseCase: sl()));
  sl.registerLazySingleton<UserRegistrationUseCase>(
      () => UserRegistrationUseCase(authRepository: sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), userStorage: sl()));

  sl.registerLazySingleton<AuthRemoteDataSource>(() =>
      AuthRemoteDataSourceImpl(authByFirebase: sl(), storageByFirebase: sl()));
  sl.registerLazySingleton<StorageByFirebase>(() => StorageByFirebaseImpl());
  sl.registerLazySingleton<AuthByFirebase>(() => AuthByFirebaseImpl());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<LocalStorage>(() => UserStorage());
  sl.registerLazySingleton<UserStorage>(() => UserStorage());

  ////// login //////

  sl.registerLazySingleton<LoginCubit>(() => LoginCubit(
      userLoginUseCase: sl(),
      googleSignInUseCase: sl(),
      facebookSignInUseCase: sl()));
  sl.registerLazySingleton<UserLoginUseCase>(
      () => UserLoginUseCase(authRepository: sl()));
  sl.registerLazySingleton<GoogleSignInUseCase>(
      () => GoogleSignInUseCase(authRepository: sl()));
  sl.registerLazySingleton<FacebookSignInUseCase>(
      () => FacebookSignInUseCase(authRepository: sl()));

  //// feeds ////
  sl.registerLazySingleton<FeedsCubit>(() => FeedsCubit(
        getUserDataUseCase: sl(),
        getAllPostsUseCase: sl(),
        postLikeUseCase: sl(),
        disLikeUseCase: sl(),
        checkLikeUseCase: sl(),
        addCommentUseCase: sl(),
        getCommentsUseCase: sl(),
        savePostUseCase: sl(),
        unSavePostUseCase: sl(),
        deletePostUseCase: sl(),
        checkSavedUseCase: sl(),
      ));
  sl.registerLazySingleton<GetUserDataUseCase>(
      () => GetUserDataUseCase(feedsRepository: sl()));
  sl.registerLazySingleton<FeedsRepository>(() => FeedsRepositoryImpl(
      networkInfo: sl(),
      feedsRemoteDataSource: sl(),
      feedsLocalDataSource: sl()));

  sl.registerLazySingleton<FeedsRemoteDataSource>(
      () => FeedsRemoteDataSourceImpl(storageByFirebase: sl(), fStorage: sl()));
  sl.registerLazySingleton<FeedsLocalDataSource>(
      () => FeedsLocalDataSourceImpl());
  sl.registerLazySingleton<PostLikeUseCase>(
      () => PostLikeUseCase(feedsRepository: sl()));
  sl.registerLazySingleton<GetAllPostsUseCase>(
      () => GetAllPostsUseCase(feedsRepository: sl()));
  sl.registerLazySingleton<DisLikeUseCase>(
      () => DisLikeUseCase(feedsRepository: sl()));
  sl.registerLazySingleton<CheckLikeUseCase>(
      () => CheckLikeUseCase(feedsRepository: sl()));
  sl.registerLazySingleton<AddCommentUseCase>(
      () => AddCommentUseCase(feedsRepository: sl()));
  sl.registerLazySingleton<GetCommentsUseCase>(
      () => GetCommentsUseCase(feedsRepository: sl()));
  sl.registerLazySingleton<SavePostUseCase>(
      () => SavePostUseCase(feedsRepository: sl()));
  sl.registerLazySingleton<UnSavePostUseCase>(
      () => UnSavePostUseCase(feedsRepository: sl()));
  sl.registerLazySingleton<DeletePostUseCase>(
      () => DeletePostUseCase(feedsRepository: sl()));

  sl.registerLazySingleton<CheckSavedUseCase>(
      () => CheckSavedUseCase(feedsRepository: sl()));

  ////////// stories ////

  sl.registerLazySingleton<StoryCubit>(() => StoryCubit(
      uploadStoryImgUseCase: sl(),
      createStoryImgUseCase: sl(),
      getAllStoriesUseCase: sl()));
  sl.registerLazySingleton<CreateStoryImgUseCase>(
      () => CreateStoryImgUseCase(storiesRepository: sl()));
  sl.registerLazySingleton<UploadStoryImgUseCase>(
      () => UploadStoryImgUseCase(storiesRepository: sl()));
  sl.registerLazySingleton<StoriesRemoteDataSource>(() =>
      StoriesRemoteDataSourceImpl(storageByFirebase: sl(), fStorage: sl()));
  sl.registerLazySingleton<StoriesRepository>(() =>
      StoriesRepositoryImpl(networkInfo: sl(), storiesRemoteDataSource: sl()));
  sl.registerLazySingleton<GetAllStoriesUseCase>(
      () => GetAllStoriesUseCase(storiesRepository: sl()));

  //// profile ////
  sl.registerLazySingleton<ProfileCubit>(() => ProfileCubit(
        updateUserUseCase: sl(),
        uploadProfileImgUseCase: sl(),
      ));
  sl.registerLazySingleton<UploadProfileImgUseCase>(
      () => UploadProfileImgUseCase(profileRepository: sl()));
  sl.registerLazySingleton<UpdateUserUseCase>(
      () => UpdateUserUseCase(profileRepository: sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl(), feedsRemoteDataSource: sl()));

  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(fStorage: sl()));
  sl.registerLazySingleton<FStorage>(() => StorageImpl());

  ///// create post /////
  sl.registerLazySingleton<CreatePostCubit>(() =>
      CreatePostCubit(uploadPostImgUseCase: sl(), createPostImgUseCase: sl()));
  sl.registerLazySingleton<UploadPostImgUseCase>(
      () => UploadPostImgUseCase(addPostRepository: sl()));
  sl.registerLazySingleton<CreatePostImgUseCase>(
      () => CreatePostImgUseCase(addPostRepository: sl()));
  sl.registerLazySingleton<AddPostRepository>(
      () => AddPostRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<AddPostRemoteDataSource>(
      () => AddPostRemoteDataSourceImpl(fStorage: sl(), firebase: sl()));

  //// messages ////
  sl.registerLazySingleton<MessagesCubit>(() => MessagesCubit(
      getAllUsersUseCase: sl(),
      sendMessageUseCase: sl(),
      getMessagesUseCase: sl()));
  sl.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(messagesRepository: sl()));
  sl.registerLazySingleton<MessagesRepository>(() => MessagesRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      allContacts: sl(),
      localDataSource: sl()));

  sl.registerLazySingleton<GetMessagesUseCase>(
      () => GetMessagesUseCase(messagesRepository: sl()));

  sl.registerLazySingleton<MessagesRemoteDataSource>(
      () => MessagesRemoteDataSourceImpl(storageByFirebase: sl()));
  sl.registerLazySingleton<AllContacts>(() => AllContactsImpl());
  sl.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(messagesRepository: sl()));
  sl.registerLazySingleton<MessagesLocalDataSource>(
      () => MessagesLocalDataSourceImpl());

  //// friend profile ////
  sl.registerLazySingleton<FriendsCubit>(() => FriendsCubit(
      friendGalleryUseCase: sl(),
      followUseCase: sl(),
      unfollowUseCase: sl(),
      getFriendFollowersUseCase: sl(),
      getFriendFollowingUseCase: sl(),
      checkFriendUseCase: sl()));
  sl.registerLazySingleton<FriendGalleryUseCase>(
      () => FriendGalleryUseCase(friendProfileRepository: sl()));
  sl.registerLazySingleton<FriendProfileRepository>(() =>
      FriendProfileRepositoryImpl(
          networkInfo: sl(), profileRemoteDataSource: sl()));

  sl.registerLazySingleton<FriendProfileRemoteDataSource>(
      () => FriendProfileRemoteDataSourceImpl(storageByFirebase: sl()));

  sl.registerLazySingleton<FollowUseCase>(
      () => FollowUseCase(friendProfileRepository: sl()));
  sl.registerLazySingleton<UnfollowUseCase>(
      () => UnfollowUseCase(friendProfileRepository: sl()));
  sl.registerLazySingleton<GetFriendFollowersUseCase>(
      () => GetFriendFollowersUseCase(friendProfileRepository: sl()));
  sl.registerLazySingleton<GetFriendFollowingUseCase>(
      () => GetFriendFollowingUseCase(friendProfileRepository: sl()));
  sl.registerLazySingleton<CheckFriendUseCase>(
      () => CheckFriendUseCase(friendProfileRepository: sl()));

  //// favourites ////
  sl.registerLazySingleton<FavouritesCubit>(
      () => FavouritesCubit(addNotificationToFbUseCase: sl()));
  sl.registerLazySingleton<AddNotificationToFbUseCase>(
      () => AddNotificationToFbUseCase(favouritesRepository: sl()));
  sl.registerLazySingleton<FavouritesRepository>(
      () => FavouritesRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<FavouritesRemoteDataSource>(
      () => FavouritesRemoteDataSourceImpl(storageByFirebase: sl()));
}
