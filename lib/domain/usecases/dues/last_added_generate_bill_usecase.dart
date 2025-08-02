import 'package:nivaas/domain/repositories/dues/last_added_generate_bill_repository.dart';

class LastAddedGenerateBillUseCase {
  final LastAddedGenerateBillRepository repository;

  LastAddedGenerateBillUseCase({required this.repository});

  Future<dynamic> call(int apartmentId) async {
    return await repository.getLastAddedGenerateBill(apartmentId);
  }
}
