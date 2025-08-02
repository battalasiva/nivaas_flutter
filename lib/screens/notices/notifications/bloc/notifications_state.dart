import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/notice-board/get_notifications_Model.dart';

abstract class GetNotificationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNotificationsInitial extends GetNotificationsState {}

class GetNotificationsLoading extends GetNotificationsState {}

class GetNotificationsLoaded extends GetNotificationsState {
  final GetNotificationsModal notifications;

  GetNotificationsLoaded(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class GetNotificationsError extends GetNotificationsState {
  final String message;

  GetNotificationsError(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteNotificationInitial extends GetNotificationsState {}

class DeleteNotificationLoading extends GetNotificationsState {}

class DeleteNotificationSuccess extends GetNotificationsState {}

class DeleteNotificationError extends GetNotificationsState {
  final String message;

  DeleteNotificationError(this.message);

  @override
  List<Object?> get props => [message];
}
