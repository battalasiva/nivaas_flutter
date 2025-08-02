abstract class EditNoticeRepository {
  Future<void> editNotice(
      int noticeId, String title, String body, int apartmentId);
}