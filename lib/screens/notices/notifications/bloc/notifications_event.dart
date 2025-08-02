import 'package:equatable/equatable.dart';

abstract class GetNotificationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNotificationsEvent extends GetNotificationsEvent {
  final int pageNo;
  final int pageSize;

  FetchNotificationsEvent(this.pageNo, this.pageSize);

  @override
  List<Object?> get props => [pageNo, pageSize];
}

class ClearAllNotificationsEvent extends GetNotificationsEvent {}
