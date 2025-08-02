import '../../../data/models/security/guest_invite_entries_model.dart';

abstract class GateActivitiesRepository {
  Future<GuestInviteEntriesModel> fetchCheckinHistory(int apartmentId, String status, int pageNo, int pageSize);
}