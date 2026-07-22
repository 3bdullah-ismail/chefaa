part of 'orders_list_cubit.dart';

abstract class OrdersListState {}

class OrdersListInitial extends OrdersListState {}

class OrdersListLoading extends OrdersListState {}

class OrdersListSuccess extends OrdersListState {
  final OrdersListResponse response;

  OrdersListSuccess(this.response);
}

class OrdersListFailure extends OrdersListState {
  final String message;

  OrdersListFailure(this.message);
}
