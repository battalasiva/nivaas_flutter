import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/managementMembers/add_management_members_usecase.dart';

import '../../../../core/error/exception_handler.dart';
import '../../../../data/models/managementMembers/coAdmin/add_coadmin_model.dart';
import '../../../../data/models/managementMembers/coAdmin/owners_list_model.dart';
import '../../../../data/models/managementMembers/security/add_security_model.dart';

part 'add_management_members_event.dart';
part 'add_management_members_state.dart';

class AddManagementMembersBloc extends Bloc<AddManagementMembersEvent, AddManagementMembersState> {
  final AddManagementMembersUsecase coadminUsecase;
  AddManagementMembersBloc(this.coadminUsecase) : super(CoAdminInitial()) {
    on<AddCoAdminEvent>((event, emit) async{
      emit(AddCoAdminLoading());
      try {
        print('details in bloc: ${event.details}');
        final success = await coadminUsecase.executeAddCoadmin(event.details);
        if (success) {
          emit(AddCoAdminSuccess());
        } else {
          emit(CoAdminFailure(message: "Failed to add Co-Admin"));
        }
      } catch (e) {
        if (e is AppException) {
          emit(CoAdminFailure(message: e.message));
        } else {
          emit(CoAdminFailure(message: e.toString()));
        }
      }
    });

    on<FetchOwnersListEvent>((event, emit) async {
      emit(OwnersListLoading());
      try {
        final response =
            await coadminUsecase.callOwnersList(event.apartmentID);
        print('-----------response in bloc: $response');
        emit(OwnersListLoaded(details: response));
      } catch (e) {
        emit(CoAdminFailure(message: e.toString()));
      }
    });

    on<AddSecurityEvent>((event, emit) async{
      emit(AddSecurityLoading());
      try {
        print('details in bloc: ${event.details}');
        final success = await coadminUsecase.executeAddSecurity(event.details);
        if (success) {
          emit(AddSecuritySuccess());
        } else {
          emit(AddSecurityFailure(message: "Failed to add Co-Admin"));
        }
      } catch (e) {
        if (e is AppException) {
          emit(AddSecurityFailure(message: e.message));
        } else {
          emit(AddSecurityFailure(message: e.toString()));
        }
      }
    });
  }
}
