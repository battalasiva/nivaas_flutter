import 'package:nivaas/data/models/notice-board/get_notifications_Model.dart';
import 'package:nivaas/domain/repositories/notice-board/get_notifications_repository.dart.dart';

class GetNotificationsUseCase {
  final GetNotificationsRepository repository;

  GetNotificationsUseCase({required this.repository});

  Future<GetNotificationsModal> call(int pageNo, int pageSize) {
    return repository.fetchNotifications(pageNo, pageSize);
  }
}
