import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fsociety/core/errors/failures.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/network/network_info.dart';
import 'package:fsociety/core/shared_preferances/cache_helper.dart';
import 'package:fsociety/core/utiles/strings.dart';
import 'package:fsociety/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:fsociety/features/authentication/data/models/current_user_model.dart';
import '../../../../core/local_storage/user_storage.dart';
import '../../domain/repositories/features_repository.dart';
import '../models/register_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;
  final UserStorage userStorage;

  AuthRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.userStorage});

  @override
  Future<Either<Failure, UserCredential>> userRegistration(
      {required RegisterBody registerBody}) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.userRegistration(registerBody: registerBody);
        final user = CurrentUser(
            name: registerBody.name!,
            email: registerBody.email!,
            phone: registerBody.phone!,
            uid: response.user!.uid,
            isEmailVerified: false,
            image: AppStrings().newUser,
            bio: AppStrings().newBio,
            deviceToken: CacheHelper.getData(key: 'DEVICE_TOKEN'));
        final addUser = await addUserToFireStore(currentUser: user);
        addUser.fold((failure) {
          return Left(failure);
        }, (success) async {
          CacheHelper.saveData(
              key: 'uid', value: response.user!.uid.toString());
        });
        return Right(response);
      } on FirebaseAuthException catch (error) {
        print(error.code);
        return Left(MyServerFailure(error: error));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> userLogin(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLogin =
            await remoteDataSource.userLogin(email: email, password: password);
        final user = await getCurrentUser(uid: remoteLogin.user!.uid);
        user.fold(
          (failure) {
            return Left(failure);
          },
          (currentUser) async {
            CacheHelper.saveData(key: 'uid', value: currentUser.uid);
            CacheHelper.saveData(key: 'DEVICE_TOKEN', value: await FirebaseMessaging.instance.getToken());
            userStorage.saveData(id: HiveKeys.currentUser, data: currentUser);
          },
        );
        return right(remoteLogin);
      } on FirebaseAuthException catch (e) {
        print('======> ${e.code}');
        return left(MyServerFailure(error: e));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addUserToFireStore(
      {required CurrentUser currentUser}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser =
            await remoteDataSource.addUserToFireStore(currentUser: currentUser);
        return right(remoteUser);
      } on FirebaseAuthException catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CurrentUser>> getCurrentUser(
      {required String uid}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getCurrentUser(uid: uid);

        return Right(response);
      } on FirebaseAuthException catch (error) {
        return Left(ServerFailure());
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> googleSignIn() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.googleSignIn();
        final googleUser = CurrentUser(
            name: response.user!.displayName,
            email: response.user!.email!,
            phone: response.user!.phoneNumber ?? '',
            uid: response.user!.uid,
            isEmailVerified: false,
            image: AppStrings().newUser,
            bio: AppStrings().newBio,
            deviceToken: CacheHelper.getData(key: 'DEVICE_TOKEN'));

        final addUser = await addUserToFireStore(currentUser: googleUser);
        addUser.fold((failure) {
          return left(failure);
        }, (success) {
          return right(addUser);
        });
        final currentUser = await getCurrentUser(uid: response.user!.uid);
        currentUser.fold((failure) {
          return left(failure);
        }, (currentUser) async {
          CacheHelper.saveData(key: 'uid', value: currentUser.uid);
          CacheHelper.saveData(key: 'DEVICE_TOKEN', value: await FirebaseMessaging.instance.getToken());
          userStorage.saveData(id: HiveKeys.currentUser, data: currentUser);
        });
        return Right(response);
      } on FirebaseAuthException catch (error) {
        return Left(ServerFailure());
      }
    } else {
      FirebaseException error =
          FirebaseException(plugin: '', code: 'no-internet-connection');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> facebookSignIn() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.facebookSignIn();
        final facebookUser = CurrentUser(
            name: response.user!.displayName,
            email: response.user!.email,
            phone: response.user!.phoneNumber ?? '',
            uid: response.user!.uid,
            isEmailVerified: true,
            image: response.user!.photoURL ?? AppStrings().newUser,
            bio: AppStrings().newBio,
            deviceToken: CacheHelper.getData(key: 'DEVICE_TOKEN')
        );

        final addUser = await addUserToFireStore(currentUser: facebookUser);
        addUser.fold((failure) {
          return left(failure);
        }, (success) {
          return right(addUser);
        });
        final currentUser = await getCurrentUser(uid: response.user!.uid);
        currentUser.fold((failure) {
          return left(failure);
        }, (currentUser) async {
          CacheHelper.saveData(key: 'uid', value: currentUser.uid);
          CacheHelper.saveData(key: 'DEVICE_TOKEN', value: await FirebaseMessaging.instance.getToken());
          userStorage.saveData(id: HiveKeys.currentUser, data: currentUser);
        });
        return Right(response);
      } on FirebaseAuthException catch (error) {
        return Left(ServerFailure());
      }
    } else {
      FirebaseException error =
          FirebaseException(plugin: '', code: 'no-internet-connection');
      return Left(ServerFailure());
    }
  }
}
