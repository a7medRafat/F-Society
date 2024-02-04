import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../local_storage/hive_keys.dart';
import '../../local_storage/user_storage.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

abstract class FStorage {
  Future<void> updateUser({required Map<String, dynamic> map});

  UploadTask uploadProfileImg({required File file});

  UploadTask uploadPostImg({required File file});

  UploadTask uploadStoryImg({required File file});
}

class StorageImpl implements FStorage {
  var store = FirebaseFirestore.instance;
  final FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  @override
  Future<void> updateUser({required Map<String, dynamic> map}) {
    return store
        .collection('users')
        .doc(di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid)
        .update(map);
  }




  @override
  UploadTask uploadProfileImg({required File file}) {
    Reference storageRef =
        storage.ref().child('users/${Uri.file(file.path).pathSegments.last}');
    return storageRef.putFile(file);
  }









  @override
  UploadTask uploadPostImg({required File file}) {

    Reference storageRef =
    storage.ref().child('posts/${Uri.file(file.path).pathSegments.last}');
    return storageRef.putFile(file);

  }

  @override
  UploadTask uploadStoryImg({required File file}) {
    Reference storageRef =
        storage.ref().child('stories/${Uri.file(file.path).pathSegments.last}');
    return storageRef.putFile(file);
  }
}
