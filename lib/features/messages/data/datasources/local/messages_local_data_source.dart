import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fsociety/core/shared_preferances/cache_helper.dart';
import 'package:fsociety/features/messages/data/models/get_all_users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/exceptions.dart';

abstract class MessagesLocalDataSource {
  Future<List<AllUsersModel>> getCachedContacts();

  Future<Unit> cacheContacts(List<AllUsersModel> usersModel);
}

class MessagesLocalDataSourceImpl implements MessagesLocalDataSource {
  //
  // PostLocalDataSourceImpl({required this.sharedPreferences});
  // @override
  // Future<Unit> cachePosts(List<PostModel> postModel) {
  //   List postModelToJson = postModel
  //       .map<Map<String, dynamic>>((postModel) => postModel.toJson())
  //       .toList();
  //   sharedPreferences.setString('CACHED_POSTS', json.encode(postModelToJson));
  //   return Future.value(unit);
  //
  // }
  //
  // @override
  // Future<List<PostModel>> getCachedPosts() {
  //   final jsonString = sharedPreferences.getString('CACHED_POSTS');
  //   if (jsonString != null) {
  //     List decodeJsonData = json.decode(jsonString);
  //     List<PostModel> jsonToPostModel = decodeJsonData
  //         .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
  //         .toList();
  //     return Future.value(jsonToPostModel);
  //   } else {
  //     throw EmptyCacheException();
  //   }
  // }

  @override
  Future<Unit> cacheContacts(List<AllUsersModel> usersModel) {
    List contactsModelToJson = usersModel
        .map<Map<String, dynamic>>((usersModel) => usersModel.toJson())
        .toList();
    CacheHelper.saveData(
        key: 'CACHED_CONTACTS', value: json.encode(contactsModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<AllUsersModel>> getCachedContacts() {
    final jsonString = CacheHelper.getData(key: 'CACHED_CONTACTS');
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<AllUsersModel> jsonToUsersModel =
          decodeJsonData.map((e) => AllUsersModel.fromJson(e)).toList();
      return Future.value(jsonToUsersModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
