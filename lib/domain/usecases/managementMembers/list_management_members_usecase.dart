import 'package:nivaas/data/models/managementMembers/list_management_members_model.dart';
import 'package:nivaas/data/repository-impl/managementMembers/list_management_members_repositoryimpl.dart';

class ListManagementMembersUsecase {
  final ListManagementMembersRepositoryimpl repository;

  ListManagementMembersUsecase({required this.repository});

  Future<ListManagementMembersModel> callSecuritiesList(int apartmentID){
    return repository.fetchSecuritiesList(apartmentID);
  }
}