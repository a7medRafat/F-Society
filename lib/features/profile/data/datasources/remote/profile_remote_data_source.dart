import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../core/firebase/storage/storage.dart';

abstract class ProfileRemoteDataSource {
  Future<void> updateUser({required Map<String, dynamic> map});

  UploadTask uploadProfileImg({required File file});
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final FStorage fStorage;

  ProfileRemoteDataSourceImpl({required this.fStorage});

  @override
  Future<void> updateUser({required Map<String, dynamic> map}) async {
    return await fStorage.updateUser(map: map);
  }

  @override
  UploadTask uploadProfileImg({required File file}) {
    return fStorage.uploadProfileImg(file: file);
  }
}
