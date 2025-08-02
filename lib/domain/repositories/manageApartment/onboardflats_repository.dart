import 'package:nivaas/data/models/manageApartment/onboarding_flat_withdetails_model.dart';
import 'package:nivaas/data/models/manageApartment/onboarding_flat_withoutdetails_model.dart';

abstract class OnboardflatsRepository {
  Future<bool>sendFlatsWithDetails(OnboardingFlatWithdetailsModel flatsWithDetails);
  Future<bool>sendFlatsWithoutDetails(OnboardingFlatWithoutdetailsModel flatsWithoutDetails);
}