part of 'notice_board_bloc.dart';

sealed class NoticeBoardState extends Equatable {
  const NoticeBoardState();

  @override
  List<Object?> get props => [];
}

final class NoticeBoardInitial extends NoticeBoardState {}

final class NoticeBoardLoading extends NoticeBoardState {}

final class NoticeBoardLoaded extends NoticeBoardState {
  final NoticeBoardModal noticeBoard;

  const NoticeBoardLoaded(this.noticeBoard);

  @override
  List<Object?> get props => [noticeBoard];
}

final class NoticeBoardError extends NoticeBoardState {
  final String error;

  const NoticeBoardError(this.error);

  @override
  List<Object?> get props => [error];
}
