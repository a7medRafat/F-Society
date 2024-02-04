import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/core/errors/exceptions.dart';
import 'package:fsociety/core/errors/failures.dart';
import 'package:fsociety/core/local_storage/all_contacts.dart';
import 'package:fsociety/core/shared_preferances/cache_helper.dart';
import 'package:fsociety/features/messages/data/datasources/local/messages_local_data_source.dart';
import 'package:fsociety/features/messages/data/models/get_all_users.dart';
import 'package:fsociety/features/messages/data/models/last_message_model.dart';
import 'package:fsociety/features/messages/domain/repositories/messages_repository.dart';
import 'package:hive/hive.dart';
import '../../../../core/local_storage/hive_keys.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/remote/messages_remote_data_source.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

import '../models/message_model.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  final NetworkInfo networkInfo;
  final MessagesRemoteDataSource remoteDataSource;
  final MessagesLocalDataSource localDataSource;
  final AllContacts allContacts;

  MessagesRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.allContacts,
    required this.localDataSource,
  });

  var box = Hive.box<AllUsersModel>(HiveKeys.contacts);

  @override
  Future<Either<Failure, List<AllUsersModel>>> getAllUsers() async {
    if (await networkInfo.isConnected) {
      List<AllUsersModel> users = [];
      try {
        final response = await remoteDataSource.getAllUsers();

        for (var e in response.docs) {
          users.add(AllUsersModel.fromJson(e.data()));
          localDataSource.cacheContacts(users);
        }
        return right(users);
      } on FirebaseException catch (e) {
        print(e.code.toString());
        return left(ServerFailure());
      }
    } else {
      try {
        final localContacts = await localDataSource.getCachedContacts();
        return right(localContacts);
      } on EmptyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> sendMessage(
      {required String receiverId,
      required String content,
      required LastMsgModel lastMsgModel}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.sendMessage(
            receiverId: receiverId,
            content: content,
            lastMsgModel: lastMsgModel);

        return right(response);
      } on FirebaseException catch (e) {
        print(e.code.toString());
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getMessages(
      {required String receiverId}) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.getMessages(receiverId: receiverId);
        return right(response);
      } on FirebaseException catch (e) {
        print(e.code.toString());
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<AllUsersModel>>> getContacts() {
    // TODO: implement getContacts
    throw UnimplementedError();
  }
}
