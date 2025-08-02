import 'package:nivaas/domain/repositories/notice-board/edit_post_repository.dart';

class EditNoticeUseCase {
  final EditNoticeRepository repository;

  EditNoticeUseCase({required this.repository});

  Future<void> call(
      int noticeId, String title, String body, int apartmentId) {
    return repository.editNotice(noticeId, title, body, apartmentId);
  }
}
