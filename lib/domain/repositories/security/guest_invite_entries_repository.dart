import 'package:nivaas/data/models/security/guest_invite_entries_model.dart';

abstract class GuestInviteEntriesRepository {
  Future<GuestInviteEntriesModel> fetchGuestInviteEntries(int apartmentId, int pageNo, int pageSize);
}