import 'package:nivaas/data/models/security/guest_invite_entries_model.dart';
import 'package:nivaas/data/repository-impl/security/guest_invite_entries_repositoryimpl.dart';

class GuestInviteEntriesUsecase {
  final GuestInviteEntriesRepositoryimpl repository;

  GuestInviteEntriesUsecase({required this.repository});
  Future<GuestInviteEntriesModel> call(int apartmentId, int pageNo, int pageSize){
    return repository.fetchGuestInviteEntries(apartmentId, pageNo, pageSize);
  }
}