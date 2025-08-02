import 'package:nivaas/data/provider/network/api/dues/last_added_generate_bill_datasource.dart';
import 'package:nivaas/domain/repositories/dues/last_added_generate_bill_repository.dart';

class LastAddedGenerateBillRepositoryImpl
    implements LastAddedGenerateBillRepository {
  final LastAddedGenerateBillDataSource dataSource;

  LastAddedGenerateBillRepositoryImpl({required this.dataSource});

  @override
  Future<dynamic> getLastAddedGenerateBill(int apartmentId) {
    return dataSource.fetchLastAddedGenerateBill(apartmentId);
  }
}
