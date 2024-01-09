import 'package:fsociety/core/firebase/firebase_auth/auth.dart';
import 'package:fsociety/core/firebase/firebase_store/firebase_firestore.dart';
import 'package:fsociety/core/firebase/storage/storage.dart';
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
import 'package:fsociety/features/authentication/domain/usecases/user_login.dart';
import 'package:fsociety/features/authentication/domain/usecases/user_registration.dart';
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
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'features/layout/cubit/feeds_cubit.dart';
import 'features/layout/data/datasources/local/feeds_local_data_source.dart';
import 'features/layout/data/datasources/remote/feeds_remote_data_source.dart';
import 'features/layout/data/repositories/feeds_repository_impl.dart';
import 'features/layout/domain/repositories/feeds_repository.dart';
import 'features/layout/domain/usecases/check_like.dart';
import 'features/stories/domain/usecases/create_story_img.dart';
import 'features/layout/domain/usecases/get_user_data.dart';

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

  sl.registerLazySingleton<LoginCubit>(
      () => LoginCubit(userLoginUseCase: sl()));
  sl.registerLazySingleton<UserLoginUseCase>(
      () => UserLoginUseCase(authRepository: sl()));

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

  sl.registerLazySingleton<StoryCubit>(() =>
      StoryCubit(uploadStoryImgUseCase: sl(), createStoryImgUseCase: sl(), getAllStoriesUseCase: sl()));
  sl.registerLazySingleton<CreateStoryImgUseCase>(() => CreateStoryImgUseCase(storiesRepository: sl()));
  sl.registerLazySingleton<UploadStoryImgUseCase>(() => UploadStoryImgUseCase(storiesRepository: sl()));
  sl.registerLazySingleton<StoriesRemoteDataSource>(() => StoriesRemoteDataSourceImpl(
      storageByFirebase: sl(), fStorage: sl()));
  sl.registerLazySingleton<StoriesRepository>(() => StoriesRepositoryImpl(
      networkInfo: sl(), storiesRemoteDataSource: sl()));
  sl.registerLazySingleton<GetAllStoriesUseCase>(() => GetAllStoriesUseCase(storiesRepository: sl()));



  //// profile ////
  sl.registerLazySingleton<ProfileCubit>(() =>
      ProfileCubit(updateUserUseCase: sl(), uploadProfileImgUseCase: sl()));
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
}
