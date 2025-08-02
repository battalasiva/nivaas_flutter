import 'package:nivaas/data/models/dues/LastAddedGenerateBill_modal.dart';

abstract class LastAddedGenerateBillRepository {
  Future<dynamic> getLastAddedGenerateBill(int apartmentId);
}
