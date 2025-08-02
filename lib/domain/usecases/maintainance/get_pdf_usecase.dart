import 'package:nivaas/domain/repositories/maintainance/get_pdf_repository.dart';


class GetPdfUseCase {
  final GetPdfRepository repository;

  GetPdfUseCase({required this.repository});

  Future<String> fetchPdf({
    required int apartmentId,
    required int year,
    required int month,
  }) async {
    return await repository.downloadPdf(apartmentId, year, month);
  }
}
