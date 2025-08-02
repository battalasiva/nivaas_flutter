import 'package:nivaas/data/provider/network/api/notice-board/create_post_data_source.dart';
import 'package:nivaas/domain/repositories/notice-board/create_post_repository.dart';

class CreatePostRepositoryImpl implements CreatePostRepository {
  final CreatePostDataSource dataSource;

  CreatePostRepositoryImpl({required this.dataSource});

  @override
  Future<dynamic> createPost(String title, String body, int apartmentId) async {
    return await dataSource.createPost(title, body, apartmentId);
  }
}
