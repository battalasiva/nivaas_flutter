import 'package:nivaas/data/provider/network/api/notice-board/delete_notification_data_source.dart';
import 'package:nivaas/domain/repositories/notice-board/delete_notification_repository.dart';

class DeleteNotificationRepositoryImpl implements DeleteNotificationRepository {
  final DeleteNotificationDatasource datasource;

  DeleteNotificationRepositoryImpl({required this.datasource});

  @override
  Future<void> clearAllNotifications() async {
    await datasource.clearAllNotifications();
  }
}
