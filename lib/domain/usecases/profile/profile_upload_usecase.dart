import 'dart:io';

import 'package:nivaas/data/provider/network/api/profile/profile_upload_data_source.dart';

class UploadProfilePicUseCase {
  final ProfilePicDataSource dataSource;

  UploadProfilePicUseCase({required this.dataSource});

  Future<bool> call(File image) async {
    return await dataSource.uploadProfilePicture(image);
  }
}
