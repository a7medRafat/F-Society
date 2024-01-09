import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fsociety/core/shared_preferances/cache_helper.dart';
import 'package:fsociety/features/addpost/data/models/post_model.dart';
import 'package:fsociety/features/authentication/data/models/current_user_model.dart';

import '../../../../../core/errors/exceptions.dart';

abstract class FeedsLocalDataSource {
  Future<Unit> cachesData(CurrentUser currentUser);

  Future<CurrentUser> getCachedData();

  Future<Unit> cachesPosts(List<PostModel> postModel);

  Future<List<PostModel>> getCachedPosts();
}

class FeedsLocalDataSourceImpl extends FeedsLocalDataSource {
  FeedsLocalDataSourceImpl();

  @override
  Future<Unit> cachesData(CurrentUser currentUser) {
    final userModelToJson = currentUser.toJson();
    CacheHelper.saveData(
        key: 'currentUser', value: json.encode(userModelToJson));
    return Future.value(unit);
  }

  @override
  Future<CurrentUser> getCachedData() {
    final jsonString = CacheHelper.getData(key: 'currentUser');
    if (jsonString != null) {
      final decodeJson = json.decode(jsonString);
      final json2UserModel = CurrentUser.fromJson(decodeJson);
      return Future.value(json2UserModel);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> cachesPosts(List<PostModel> postModel) {
    List postModelToJson = postModel.map<Map<String,dynamic>>((e) => e.toJson()).toList();
    CacheHelper.saveData(key: 'posts', value: json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = CacheHelper.getData(key: 'posts');
    if (jsonString != null) {
      List decodeJson = json.decode(jsonString);
      List<PostModel> json2PostModel = decodeJson.map<PostModel>((e) => PostModel.fromJson(e)).toList();
      return Future.value(json2PostModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
