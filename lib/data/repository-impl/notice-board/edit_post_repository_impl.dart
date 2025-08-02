import 'package:nivaas/data/provider/network/api/notice-board/edit_notice_data_source.dart';
import 'package:nivaas/domain/repositories/notice-board/edit_post_repository.dart';

class EditNoticeRepositoryImpl implements EditNoticeRepository {
  final EditNoticeDataSource dataSource;

  EditNoticeRepositoryImpl({required this.dataSource});

  @override
  Future<void> editNotice(
      int noticeId, String title, String body, int apartmentId) async {
    return dataSource.editNotice(noticeId, title, body, apartmentId);
  }
}