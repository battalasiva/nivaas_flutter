import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/repositories/coins-subscription/subscription_repository.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository _repository;

  SubscriptionBloc({required SubscriptionRepository repository})
      : _repository = repository,
        super(SubscriptionInitial()) {
    on<FetchSubscriptionPlansEvent>(_onFetchSubscriptionPlansEvent);
  }

  Future<void> _onFetchSubscriptionPlansEvent(FetchSubscriptionPlansEvent event,
      Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoadingState());
    try {
      final response = await _repository.getSubscriptionPlans(event.customerId);
      if (response.plans.isNotEmpty) {
        final plans = response.plans;
        emit(SubscriptionLoadedState(plans));
      } else {
        emit(SubscriptionErrorState('No subscription plans available'));
      }
    } catch (e) {
      emit(SubscriptionErrorState('Error: $e'));
    }
  }
}
