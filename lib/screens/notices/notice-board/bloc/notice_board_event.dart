part of 'notice_board_bloc.dart';

sealed class NoticeBoardEvent extends Equatable {
  const NoticeBoardEvent();

  @override
  List<Object?> get props => [];
}

final class FetchNoticeBoard extends NoticeBoardEvent {
  final int apartmentId;
  final int pageNo;
  final int pageSize;

  const FetchNoticeBoard(this.apartmentId, this.pageNo, this.pageSize);

  @override
  List<Object?> get props => [apartmentId, pageNo, pageSize];
}
