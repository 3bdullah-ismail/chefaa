import 'package:chefaa/features/patient/payment/data/models/online_payment_response.dart';
import 'package:chefaa/features/patient/payment/domain/repositories/online_payment_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'payment_state.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  final OnlinePaymentRepo onlinePaymentRepo;

  PaymentCubit(this.onlinePaymentRepo) : super(PaymentInitial());

  Future<void> processOnlinePayment(Map<String, dynamic> paymentData) async {
    if (!isClosed) emit(PaymentLoading());

    final result = await onlinePaymentRepo.processOnlinePayment(paymentData);

    result.fold(
      ifLeft: (failure) => isClosed ? null : emit(PaymentFailure(failure.message)),
      ifRight: (response) => isClosed ? null : emit(PaymentSuccess(response)),
    );
  }
}
