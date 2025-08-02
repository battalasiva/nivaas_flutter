import 'package:nivaas/domain/repositories/apartmentOnboarding/remaind_request_repository.dart';

class RemaindRequestUseCase {
  final RemaindRequestRepository repository;

  RemaindRequestUseCase({required this.repository});

  Future<String> call(String apartmentId, String flatId, String onboardingId) {
    return repository.remindRequest(apartmentId, flatId, onboardingId);
  }
}
