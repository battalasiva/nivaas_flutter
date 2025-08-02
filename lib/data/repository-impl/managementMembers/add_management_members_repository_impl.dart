import 'package:nivaas/data/models/managementMembers/coAdmin/add_coadmin_model.dart';
import 'package:nivaas/data/models/managementMembers/coAdmin/owners_list_model.dart';
import 'package:nivaas/data/provider/network/api/managementMembers/add_management_members_datasource.dart';
import 'package:nivaas/domain/repositories/managementMembers/add_management_members_repository.dart';

import '../../models/managementMembers/security/add_security_model.dart';

class AddManagementMembersRepositoryImpl implements AddManagementMembersRepository {
  final AddManagementMembersDatasource datasource;

  AddManagementMembersRepositoryImpl({required this.datasource});
  @override
  Future<bool> addCoadmin(AddCoAdminModel details) {
    return datasource.addCoAdmin(details);
  }

  @override
  Future<OwnersListModel> fetchOwnersList(int apartmentID) async{
    try {
      final response = await datasource.fetchOwnersList(apartmentID);
      print('In repository, received response: $response'); 
      return response;
    } catch (e, stacktrace) {
      print('Error in repository: $e'); 
      rethrow; 
    }
  }

  @override
  Future<bool> addSecurity(AddSecurityModel details) {
    return datasource.addSecurity(details);
  }
}