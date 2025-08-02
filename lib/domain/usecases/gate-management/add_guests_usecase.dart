import 'package:nivaas/data/models/gate-management/CreateInviteModel.dart';
import 'package:nivaas/domain/repositories/gate-management/add_guests_repository.dart';

class AddGuestsUseCase {
  final AddGuestsRepository repository;

  AddGuestsUseCase(this.repository);

  Future<CreateInviteModel> call(Map<String, dynamic> payload) {
    return repository.addGuest(payload);
  }
}
