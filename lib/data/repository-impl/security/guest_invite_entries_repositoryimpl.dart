import 'package:nivaas/data/models/security/guest_invite_entries_model.dart';
import 'package:nivaas/data/provider/network/api/security/guest_invite_entries_datasource.dart';
import 'package:nivaas/domain/repositories/security/guest_invite_entries_repository.dart';

class GuestInviteEntriesRepositoryimpl implements GuestInviteEntriesRepository {
  final GuestInviteEntriesDatasource datasource;

  GuestInviteEntriesRepositoryimpl({required this.datasource});
  @override
  Future<GuestInviteEntriesModel> fetchGuestInviteEntries(int apartmentId, int pageNo, int pageSize) {
    return datasource.fetchGuestInviteEntries(apartmentId, pageNo, pageSize);
  }
  
}