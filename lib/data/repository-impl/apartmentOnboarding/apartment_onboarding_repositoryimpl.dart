import 'package:nivaas/data/models/apartmentOnboarding/apartment_onboard_model.dart';
import 'package:nivaas/data/provider/network/api/apartmentOnboarding/apartment_onboarding_datasource.dart';
import 'package:nivaas/domain/repositories/apartmentOnboarding/apartment_onboarding_repository.dart';

class ApartmentOnboardingRepositoryimpl  implements ApartmentOnboardingRepository{
  final ApartmentOnboardingDatasource datasource;

  ApartmentOnboardingRepositoryimpl({required this.datasource});
  @override
  Future<bool> postApartmentDetails(ApartmentOnboard apartment) {
    return datasource.sendApartmentDetails(apartment);
  }
  
}