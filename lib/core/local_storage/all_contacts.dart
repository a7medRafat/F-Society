import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/features/messages/data/models/get_all_users.dart';
import 'package:hive/hive.dart';

abstract class AllContacts {
  Future<void> init();

  Future<void> saveData({required String id, required AllUsersModel data});

  Future<void> deleteData({required String id});

  AllUsersModel? getData({required String id});

}

class AllContactsImpl implements AllContacts {


  static Box<AllUsersModel>? myBox;

  @override
  Future<void> init() async {
    myBox = await Hive.openBox<AllUsersModel>(HiveKeys.contacts);
  }

  @override
  AllUsersModel? getData({required String id}) => myBox!.get(id);

  @override
  Future<void> saveData(
      {required String id, required AllUsersModel data}) async {
    await myBox!.put(id, data);
    await myBox!.flush();
  }


  @override
  Future<void> deleteData({required String id}) async {
    await myBox!.delete(id);
  }
}
