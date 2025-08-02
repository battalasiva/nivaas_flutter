import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/managementMembers/list_management_members_model.dart';
import 'package:nivaas/domain/usecases/managementMembers/list_management_members_usecase.dart';

part 'management_members_event.dart';
part 'management_members_state.dart';

class ManagementMembersBloc extends Bloc<ManagementMembersEvent, ManagementMembersState> {
  final ListManagementMembersUsecase listManagementMembersUsecase;
  ManagementMembersBloc(this.listManagementMembersUsecase) : super(ManagementMembersInitial()) {
    on<FetchSecuritiesListEvent>((event, emit) async{
      emit(ListManagementMembersLoading());
      try {
        final response =await listManagementMembersUsecase.callSecuritiesList(event.apartmentId);
        emit(ListManagementMembersLoaded(details: response));
      } catch (e) {
        emit(ListManagementMembersFailure(message: e.toString()));
      }
    });
  }
}
