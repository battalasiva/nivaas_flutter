import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/complaints/my_complaints_model.dart';
import 'package:nivaas/domain/repositories/complaints/my_complaints_repository.dart';

part 'my_complaints_event.dart';
part 'my_complaints_state.dart';

class MyComplaintsBloc extends Bloc<MyComplaintsEvent, MyComplaintsState> {
  final MyComplaintsRepository repository;
  MyComplaintsBloc({required this.repository}) : super(MyComplaintsInitial()) {
    on<FetchMyComplaintsEvent>((event, emit) async {
      emit(MyComplaintsLoading());
      try {
        final complaints = await repository.getComplaints(
          apartmentId: event.apartmentId,
          pageNo: event.pageNo,
          pageSize: event.pageSize,
        );
        emit(MyComplaintsLoaded(complaints));
      } catch (e) {
        emit(MyComplaintsError(e.toString()));
      }
    });
  }
}
