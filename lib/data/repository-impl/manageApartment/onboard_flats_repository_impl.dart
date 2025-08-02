import 'package:nivaas/data/models/manageApartment/onboarding_flat_withdetails_model.dart';
import 'package:nivaas/data/models/manageApartment/onboarding_flat_withoutdetails_model.dart';
import 'package:nivaas/data/provider/network/api/manageApartment/onboardflats_datasource.dart';
import 'package:nivaas/domain/repositories/manageApartment/onboardflats_repository.dart';

class OnboardFlatsRepositoryImpl implements OnboardflatsRepository {
  final OnboardflatsDatasource onboardflatsDatasource;

  OnboardFlatsRepositoryImpl({required this.onboardflatsDatasource});
  @override
  Future<bool> sendFlatsWithDetails(OnboardingFlatWithdetailsModel flatsWithDetails) {
    return onboardflatsDatasource.onBoardFlatsWithDetails(flatsWithDetails);
  }

  @override
  Future<bool> sendFlatsWithoutDetails(OnboardingFlatWithoutdetailsModel flatsWithoutDetails) {
    return onboardflatsDatasource.onBoardFlatsWithoutDetails(flatsWithoutDetails);
  }
  
}