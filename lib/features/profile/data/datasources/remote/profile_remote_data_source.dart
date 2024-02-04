import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fsociety/core/firebase/firebase_store/firebase_firestore.dart';

import '../../../../../core/firebase/storage/storage.dart';
import '../../../../usersprofile/data/models/following_model.dart';

abstract class ProfileRemoteDataSource {
  Future<void> updateUser({required Map<String, dynamic> map});

  UploadTask uploadProfileImg({required File file});

}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final FStorage fStorage;


  ProfileRemoteDataSourceImpl({required this.fStorage });

  @override
  Future<void> updateUser({required Map<String, dynamic> map}) async {
    return await fStorage.updateUser(map: map);
  }

  @override
  UploadTask uploadProfileImg({required File file}) {
    return fStorage.uploadProfileImg(file: file);
  }


}
