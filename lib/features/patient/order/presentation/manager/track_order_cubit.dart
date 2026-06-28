import 'package:chefaa/features/patient/order/data/models/confirm_receipt_response.dart';
import 'package:chefaa/features/patient/order/data/models/track_order_response.dart';
import 'package:chefaa/features/patient/order/domain/repositories/track_order_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'track_order_state.dart';

@injectable
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final TrackOrderRepo trackOrderRepo;

  TrackOrderCubit(this.trackOrderRepo) : super(TrackOrderInitial());

  Future<void> getOrderTracking(String orderId) async {
    if (!isClosed) emit(TrackOrderLoading());

    final result = await trackOrderRepo.getOrderTracking(orderId);

    result.fold(
      ifLeft: (failure) => isClosed ? null : emit(TrackOrderFailure(failure.message)),
      ifRight: (response) => isClosed ? null : emit(TrackOrderSuccess(response)),
    );
  }

  Future<void> confirmOrderReceipt(String orderId) async {
    if (!isClosed) emit(ConfirmReceiptLoading());

    final result = await trackOrderRepo.confirmOrderReceipt(orderId);

    result.fold(
      ifLeft: (failure) => isClosed ? null : emit(ConfirmReceiptFailure(failure.message)),
      ifRight: (response) => isClosed ? null : emit(ConfirmReceiptSuccess(response)),
    );
  }
}
