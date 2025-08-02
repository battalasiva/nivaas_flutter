import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/repositories/coins-subscription/purchase_plan_repository.dart';
import 'package:nivaas/domain/usecases/coins-subscription/create_payment_order_usecase.dart';
import 'package:nivaas/domain/usecases/coins-subscription/verify_payment_order_usecase.dart';

part 'purchase_plan_event.dart';
part 'purchase_plan_state.dart';

class PurchasePlanBloc extends Bloc<PurchasePlanEvent, PurchasePlanState> {
  final PurchasePlanRepository repository;
  final CreatePaymentOrderUseCase useCase;
  final VerifyPaymentOrderUseCase verifyPaymentOrderUseCase;

  PurchasePlanBloc({required this.repository, required this.useCase,required this.verifyPaymentOrderUseCase})
      : super(PurchasePlanInitial()) {
    on<PurchasePlanRequestedEvent>(
      (event, emit) async {
        emit(PurchasePlanLoading());
        try {
          final result =
              await repository.purchasePlan(event.apartmentId, event.months);
          if (result['isError'] == true) {
            emit(PurchasePlanFailure(result['message']));
          } else {
            emit(PurchasePlanSuccess(result['message'], isError: false));
          }
        } catch (e) {
          emit(PurchasePlanFailure(e.toString()));
        }
      },
    );
    on<PurchasePlanPaymentRequestedEvent>(
      (event, emit) async {
        emit(PurchasePlanPaymentLoading());
        try {
          final result =
              await repository.purchasePlan(event.apartmentId, event.months);
          if (result['isError'] == true) {
            emit(PurchasePlanFailure(result['message']));
          } else {
            emit(PurchasePlanPaymentSuccess(result['message'], isError: false));
          }
        } catch (e) {
          emit(PurchasePlanPaymentFailure(e.toString()));
        }
      },
    );
    //create order
    on<CreatePaymentOrderButtonPressed>((event, emit) async {
      emit(CreatePaymentOrderLoading());
      try {
        final result = await useCase(
          apartmentId: event.apartmentId,
          months: event.months,
          coinsToUse: event.coinsToUse,
        );
        if (result['success']) {
          emit(CreatePaymentOrderSuccess(result['message'], result['data']));
        } else {
          emit(CreatePaymentOrderFailure(result['message']));
        }
      } catch (e) {
        emit(CreatePaymentOrderFailure(e.toString()));
      }
    });
    //verify order
    on<VerifyPaymentOrderButtonPressed>((event, emit) async {
      emit(VerifyPaymentOrderLoading());
      try {
        final result = await verifyPaymentOrderUseCase(
          paymentId: event.paymentId,
          orderId: event.orderId,
          signature: event.signature,
        );
        if (result['success']) {
          emit(VerifyPaymentOrderSuccess(result['message'], result['data']));
        } else {
          emit(VerifyPaymentOrderFailure(result['message']));
        }
      } catch (e) {
        emit(VerifyPaymentOrderFailure(e.toString()));
      }
    });
  }
}

// context.read<PurchasePlanBloc>().add(
//                                       CreatePaymentOrderButtonPressed(
//                                         apartmentId: apartmentId,
//                                         months: months,
//                                         coinsToUse: coinsToUse,
//                                       ),);
// context.read<PurchasePlanBloc>().add(
//                                       VerifyPaymentOrderButtonPressed(
//                                         paymentId: paymentId,
//                                         orderId: orderId,
//                                         signature: signature,
//                                       ),);