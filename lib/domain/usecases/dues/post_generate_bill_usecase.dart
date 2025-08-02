import 'package:nivaas/domain/repositories/dues/post_generate_bill_repository.dart';


class PostGenerateBillUseCase {
  final PostGenerateBillRepository repository;

  PostGenerateBillUseCase({required this.repository});

  Future<String> call(Map<String, dynamic> payload) {
    return repository.generateBill(payload);
  }
}
