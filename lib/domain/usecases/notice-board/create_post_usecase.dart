import 'package:nivaas/domain/repositories/notice-board/create_post_repository.dart';

class CreatePostUseCase {
  final CreatePostRepository repository;

  CreatePostUseCase(this.repository);

  Future<dynamic> call(String title, String body, int apartmentId) {
    return repository.createPost(title, body, apartmentId);
  }
}
