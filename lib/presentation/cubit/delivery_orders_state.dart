part of 'delivery_orders_cubit.dart';

abstract class DeliveryOrdersState extends Equatable {
  final String status;
  final List<DeliverOrderModel> stockList;
  final List<DeliverOrderModel> deliveredList;
  final List<DeliverOrderModel> pendingList;
  final CustomError? customError;
  final String? message;

  const DeliveryOrdersState(
      {this.status = "initial",
      this.deliveredList = const [],
      this.pendingList = const [],
      this.stockList = const [],
      this.customError,
      this.message});

  @override
  List<Object> get props => [
        status,
        stockList,
        deliveredList,
        pendingList,
        customError ?? "",
        message ?? "",
      ];
}

class DeliveryOrdersInitial extends DeliveryOrdersState {
  const DeliveryOrdersInitial() : super();
}

class LoadingState extends DeliveryOrdersState {
  const LoadingState() : super(status: "loading");
}

class LoadedState extends DeliveryOrdersState {
  const LoadedState(
      {required super.stockList,
      required super.deliveredList,
      required super.pendingList})
      : super(
          status: "loaded",
        );

  @override
  List<Object> get props => [
        stockList,
        deliveredList,
        pendingList,
      ];
}

class ShowMessageState extends DeliveryOrdersState {
  const ShowMessageState({required super.message});
}

class ErrorOccurredState extends DeliveryOrdersState {
  const ErrorOccurredState({required super.customError});
}

class SearchRefreshState extends DeliveryOrdersState {
  const SearchRefreshState();
}

class SentReturnRequest extends DeliveryOrdersState {
  const SentReturnRequest({required super.message});
}


