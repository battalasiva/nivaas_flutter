import 'package:nivaas/data/models/notice-board/get_notifications_Model.dart';

abstract class GetNotificationsRepository {
  Future<GetNotificationsModal> fetchNotifications(int pageNo, int pageSize);
}
