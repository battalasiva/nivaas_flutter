import 'package:nivaas/data/models/gate-management/CreateInviteModel.dart';
import 'package:nivaas/data/provider/network/api/gate-management/add_guests_datasource.dart';
import 'package:nivaas/domain/repositories/gate-management/add_guests_repository.dart';

class AddGuestsRepositoryImpl implements AddGuestsRepository {
  final AddGuestsDataSource dataSource;

  AddGuestsRepositoryImpl(this.dataSource);

  @override
  Future<CreateInviteModel> addGuest(Map<String, dynamic> payload) {
    return dataSource.addGuest(payload);
  }
}
