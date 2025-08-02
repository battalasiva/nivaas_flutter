import 'package:nivaas/data/models/notice-board/noticeBoard_Model.dart';

abstract class NoticeBoardRepository {
  Future<NoticeBoardModal> fetchNoticeBoard(
      int apartmentId, int pageNo, int pageSize);
}
