import 'package:nivaas/data/models/manageApartment/onboarding_flat_withdetails_model.dart';
import 'package:nivaas/data/repository-impl/manageApartment/onboard_flats_repository_impl.dart';

import '../../../data/models/manageApartment/onboarding_flat_withoutdetails_model.dart';

class OnboardFlatsUsecase {
  final OnboardFlatsRepositoryImpl repository;

  OnboardFlatsUsecase({required this.repository});

  Future<bool> executeFlatWithDetails(OnboardingFlatWithdetailsModel flatsWithDetails){
    return repository.sendFlatsWithDetails(flatsWithDetails);
  }
  Future<bool> executeFlatWithoutDetails(OnboardingFlatWithoutdetailsModel flatsWithoutDetails){
    return repository.sendFlatsWithoutDetails(flatsWithoutDetails);
  }
}