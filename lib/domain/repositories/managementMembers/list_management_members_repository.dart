import 'package:nivaas/data/models/managementMembers/list_management_members_model.dart';

abstract class ListManagementMembersRepository {
  Future<ListManagementMembersModel> fetchSecuritiesList(int apartmentID);
}