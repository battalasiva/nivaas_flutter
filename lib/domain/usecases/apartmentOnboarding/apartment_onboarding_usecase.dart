import 'package:nivaas/data/models/apartmentOnboarding/apartment_onboard_model.dart';
import 'package:nivaas/data/repository-impl/apartmentOnboarding/apartment_onboarding_repositoryimpl.dart';

class ApartmentOnboardingUsecase {
  final ApartmentOnboardingRepositoryimpl repository;

  ApartmentOnboardingUsecase({required this.repository});

  Future<bool> execute(ApartmentOnboard apartment){
    return repository.postApartmentDetails(apartment);
  }
}