part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

class CreatePostRequested extends CreatePostEvent {
  final String title;
  final String body;
  final int apartmentId;

  const CreatePostRequested({
    required this.title,
    required this.body,
    required this.apartmentId,
  });

  @override
  List<Object> get props => [title, body, apartmentId];
}

final class EditNotice extends CreatePostEvent {
  final int noticeId;
  final String title;
  final String body;
  final int apartmentId;

  const EditNotice(this.noticeId, this.title, this.body, this.apartmentId);

  @override
  List<Object> get props => [noticeId, title, body, apartmentId];
}
