import 'package:nivaas/data/models/apartmentOnboarding/apartment_onboard_model.dart';

abstract class ApartmentOnboardingRepository {
  Future<bool>postApartmentDetails(ApartmentOnboard apartment);
}