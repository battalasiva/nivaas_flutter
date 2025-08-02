part of 'create_post_bloc.dart';

abstract class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object> get props => [];
}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}

class CreatePostSuccess extends CreatePostState {
  CreatePostSuccess(response);
}

class CreatePostFailure extends CreatePostState {
  final String error;

  const CreatePostFailure(this.error);

  @override
  List<Object> get props => [error];
}

class EditNoticeLoading extends CreatePostState {}

class EditNoticeLoaded extends CreatePostState {
  final String message;

  const EditNoticeLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class EditNoticeError extends CreatePostState {
  final String error;

  const EditNoticeError(this.error);

  @override
  List<Object> get props => [error];
}
