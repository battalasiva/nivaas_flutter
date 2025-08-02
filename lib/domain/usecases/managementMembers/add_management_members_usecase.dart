import 'package:nivaas/data/models/managementMembers/coAdmin/add_coadmin_model.dart';
import 'package:nivaas/data/repository-impl/managementMembers/add_management_members_repository_impl.dart';

import '../../../data/models/managementMembers/coAdmin/owners_list_model.dart';
import '../../../data/models/managementMembers/security/add_security_model.dart';

class AddManagementMembersUsecase {
  final AddManagementMembersRepositoryImpl repository;

  AddManagementMembersUsecase({required this.repository});

  Future<bool> executeAddCoadmin(AddCoAdminModel details){
    return repository.addCoadmin(details);
  }

  Future<OwnersListModel> callOwnersList(int apartmentID){
    return repository.fetchOwnersList(apartmentID);
  }

  Future<bool>executeAddSecurity(AddSecurityModel details){
    return repository.addSecurity(details);
  }
}