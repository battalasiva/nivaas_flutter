import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/notice-board/noticeBoard_Model.dart';
import 'package:nivaas/domain/repositories/notice-board/notice_board_reposotory.dart';

part 'notice_board_event.dart';
part 'notice_board_state.dart';

class NoticeBoardBloc extends Bloc<NoticeBoardEvent, NoticeBoardState> {
  final NoticeBoardRepository repository;
  NoticeBoardBloc({required this.repository}) : super(NoticeBoardInitial()) {
    on<FetchNoticeBoard>((event, emit) async {
      emit(NoticeBoardLoading());
      try {
        final noticeBoard = await repository.fetchNoticeBoard(
            event.apartmentId, event.pageNo, event.pageSize);
        emit(NoticeBoardLoaded(noticeBoard));
      } catch (e) {
        emit(NoticeBoardError(e.toString()));
      }
    });
  }
}
