import 'package:cloud_firestore/cloud_firestore.dart';

import '../local_storage/user_storage.dart';
import '../shared_preferances/cache_helper.dart';

class Collections {
  CollectionReference<Map<String, dynamic>> posts =
      FirebaseFirestore.instance.collection('posts');

  CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');

  final myFollowingCol = FirebaseFirestore.instance
      .collection('users')
      .doc(CacheHelper.getData(key: 'uid'))
      .collection('following');

  final myFollowersCol = FirebaseFirestore.instance
      .collection('users')
      .doc(CacheHelper.getData(key: 'uid'))
      .collection('followers');

  final postsCol = FirebaseFirestore.instance.collection('posts');

  final chatCol =  FirebaseFirestore.instance.collection('users')
      .doc(CacheHelper.getData(key: 'uid'))
      .collection('chats');

  final storiesCol =  FirebaseFirestore.instance.collection('stories');
}
