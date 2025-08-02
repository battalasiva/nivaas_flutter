import 'package:nivaas/data/provider/network/api/dues/post_generate_bill_datasource.dart';
import 'package:nivaas/domain/repositories/dues/post_generate_bill_repository.dart';

class PostGenerateBillRepositoryImpl implements PostGenerateBillRepository {
  final PostGenerateBillDataSource dataSource;

  PostGenerateBillRepositoryImpl({required this.dataSource});

  @override
  Future<String> generateBill(Map<String, dynamic> payload) {
    return dataSource.generateBill(payload);
  }
}
