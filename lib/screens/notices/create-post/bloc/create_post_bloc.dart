import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/repositories/notice-board/create_post_repository.dart';
import 'package:nivaas/domain/repositories/notice-board/edit_post_repository.dart';
import 'package:nivaas/domain/usecases/notice-board/edit_Notice_usecase.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final CreatePostRepository repository;
  // final EditNoticeRepository editNoticeRepository;
   final EditNoticeUseCase editNoticeUseCase;

  CreatePostBloc({required this.repository, required this.editNoticeUseCase})
      : super(CreatePostInitial()) {
    on<CreatePostRequested>((event, emit) async {
      emit(CreatePostLoading());
      try {
        final response = await repository.createPost(
            event.title, event.body, event.apartmentId);
        emit(CreatePostSuccess(response));
      } catch (error) {
        emit(CreatePostFailure(error.toString()));
      }
    });
    on<EditNotice>((event, emit) async {
      emit(EditNoticeLoading());
      try {
        await editNoticeUseCase(
          event.noticeId,
          event.title,
          event.body,
          event.apartmentId,
        );
        emit(EditNoticeLoaded("Notice updated successfully."));
      } catch (e) {
        emit(EditNoticeError("Failed to update notice: ${e.toString()}"));
      }
    });
  }
}
