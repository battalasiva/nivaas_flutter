import 'package:nivaas/domain/repositories/notice-board/delete_notification_repository.dart';

class DeleteNotificationUseCase {
  final DeleteNotificationRepository repository;

  DeleteNotificationUseCase({required this.repository});

  Future<void> execute() async {
    await repository.clearAllNotifications();
  }
}
