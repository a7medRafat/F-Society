import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fsociety/core/errors/failures.dart';

import '../repositories/profile_repository.dart';

class UploadProfileImgUseCase {
  final ProfileRepository profileRepository;

  UploadProfileImgUseCase({required this.profileRepository});

  Future<Either<Failure, String>> call({required File file})  {
    return profileRepository.uploadProfileImg(file: file);
  }
}
