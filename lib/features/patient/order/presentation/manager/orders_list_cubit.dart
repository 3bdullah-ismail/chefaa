import 'package:chefaa/features/patient/order/data/models/orders_list_response.dart';
import 'package:chefaa/features/patient/order/domain/repositories/orders_list_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'orders_list_state.dart';

@injectable
class OrdersListCubit extends Cubit<OrdersListState> {
  final OrdersListRepo ordersListRepo;

  OrdersListCubit(this.ordersListRepo) : super(OrdersListInitial());

  Future<void> getMyOrders() async {
    if (!isClosed) emit(OrdersListLoading());

    final result = await ordersListRepo.getMyOrders();

    result.fold(
      ifLeft: (failure) =>
          isClosed ? null : emit(OrdersListFailure(failure.message)),
      ifRight: (response) =>
          isClosed ? null : emit(OrdersListSuccess(response)),
    );
  }
}
