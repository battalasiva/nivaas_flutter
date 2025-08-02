import 'dart:io';

import 'package:nivaas/data/provider/network/api/profile/profile_upload_data_source.dart';
import 'package:nivaas/domain/repositories/profile/profile_upload_repository.dart';

class ProfilePicRepositoryImpl implements ProfilePicRepository {
  final ProfilePicDataSource _dataSource;

  ProfilePicRepositoryImpl({required ProfilePicDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<bool> uploadProfilePicture(File image) async {
    return await _dataSource.uploadProfilePicture(image);
  }
}
