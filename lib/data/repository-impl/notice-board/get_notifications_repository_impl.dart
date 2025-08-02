import 'package:nivaas/data/models/notice-board/get_notifications_Model.dart';
import 'package:nivaas/data/provider/network/api/notice-board/notification_data_source.dart';
import 'package:nivaas/domain/repositories/notice-board/get_notifications_repository.dart.dart';

class GetNotificationsRepositoryImpl implements GetNotificationsRepository {
  final GetNotificationsDataSource dataSource;

  GetNotificationsRepositoryImpl({required this.dataSource});

  @override
  Future<GetNotificationsModal> fetchNotifications(int pageNo, int pageSize) {
    return dataSource.fetchNotifications(pageNo, pageSize);
  }
}
