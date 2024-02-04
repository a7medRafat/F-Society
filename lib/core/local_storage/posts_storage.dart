import 'package:fsociety/features/addpost/data/models/post_model.dart';
import 'package:hive/hive.dart';

import 'hive_keys.dart';

abstract class LocalPost<PostModel> {
  Future<void> init();

  Future<void> saveData({required String id, required PostModel data});

  Future<void> deleteData({required String id});

  PostModel? getData({required String id});
}

class PostsStorage implements LocalPost {
  static Box<PostModel>? _box;

  @override
  Future<void> deleteData({required String id}) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  PostModel? getData({required String id}) => _box!.get(id);

  @override
  Future<void> init() async {
    _box = await Hive.openBox(HiveKeys.posts);
  }

  @override
  Future<void> saveData({required String id, required dynamic data}) async {
    await _box!.put(id, data);
    await _box!.flush();
  }
}
