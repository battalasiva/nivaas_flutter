import 'package:nivaas/domain/repositories/prepaid-meters/edit_prepaid_meter_repoasitory.dart';

class EditPrepaidMeterUsecase {
  final EditPrepaidMeterRepoasitory repository;
  EditPrepaidMeterUsecase({required this.repository});
  Future<String> updatePrepaidMeter(Map<String, dynamic> payload) {
    return repository.editPrepaidMeter(payload);
  }
}
