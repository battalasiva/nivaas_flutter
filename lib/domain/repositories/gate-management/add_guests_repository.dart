import 'package:nivaas/data/models/gate-management/CreateInviteModel.dart';

abstract class AddGuestsRepository {
  Future<CreateInviteModel> addGuest(Map<String, dynamic> payload);
}
