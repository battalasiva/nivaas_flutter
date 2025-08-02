import 'package:nivaas/data/models/managementMembers/coAdmin/add_coadmin_model.dart';

import '../../../data/models/managementMembers/coAdmin/owners_list_model.dart';
import '../../../data/models/managementMembers/security/add_security_model.dart';

abstract class AddManagementMembersRepository {
  Future<bool>addCoadmin(AddCoAdminModel details);
  Future<OwnersListModel> fetchOwnersList(int apartmentID);
  Future<bool>addSecurity(AddSecurityModel details);
}