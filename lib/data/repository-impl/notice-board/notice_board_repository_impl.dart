import 'package:nivaas/data/models/notice-board/noticeBoard_Model.dart';
import 'package:nivaas/data/provider/network/api/notice-board/notice_board_data_source.dart';
import 'package:nivaas/domain/repositories/notice-board/notice_board_reposotory.dart';

class NoticeBoardRepositoryImpl implements NoticeBoardRepository {
  final NoticeBoardDataSource dataSource;

  NoticeBoardRepositoryImpl({required this.dataSource});

  @override
  Future<NoticeBoardModal> fetchNoticeBoard(
      int apartmentId, int pageNo, int pageSize) {
    return dataSource.fetchNotices(apartmentId, pageNo, pageSize);
  }
}
