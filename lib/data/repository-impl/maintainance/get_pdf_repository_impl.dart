import 'package:nivaas/data/provider/network/api/maintainance/get_pdf_datasource.dart';
import 'package:nivaas/domain/repositories/maintainance/get_pdf_repository.dart';


class GetPdfRepositoryImpl implements GetPdfRepository {
  final GetPdfDataSource dataSource;

  GetPdfRepositoryImpl({required this.dataSource});

  @override
  Future<String> downloadPdf(int apartmentId, int year, int month) async {
    return await dataSource.fetchPdf(apartmentId, year, month);
  }
}
