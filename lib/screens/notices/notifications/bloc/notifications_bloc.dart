import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/domain/usecases/notice-board/delete_notofication_usecase.dart';
import 'package:nivaas/domain/usecases/notice-board/get_notifications_usecase.dart';
import 'package:nivaas/screens/notices/notifications/bloc/notifications_event.dart';
import 'package:nivaas/screens/notices/notifications/bloc/notifications_state.dart';

class GetNotificationsBloc
    extends Bloc<GetNotificationsEvent, GetNotificationsState> {
  final GetNotificationsUseCase getNotificationUsecase;
  final DeleteNotificationUseCase deleteNotificationUseCase;

  GetNotificationsBloc(
      this.getNotificationUsecase, this.deleteNotificationUseCase)
      : super(GetNotificationsInitial()) {
    on<FetchNotificationsEvent>((event, emit) async {
      emit(GetNotificationsLoading());
      try {
        final result =
            await getNotificationUsecase.call(event.pageNo, event.pageSize);
        emit(GetNotificationsLoaded(result));
      } catch (error) {
        emit(GetNotificationsError(error.toString()));
      }
    });

    on<ClearAllNotificationsEvent>((event, emit) async {
      emit(DeleteNotificationLoading());
      try {
        await deleteNotificationUseCase.execute();
        emit(DeleteNotificationSuccess());
      } catch (error) {
        emit(DeleteNotificationError(error.toString()));
      }
    });
  }
}
