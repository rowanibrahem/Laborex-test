part of 'delivery_orders_cubit.dart';

abstract class DeliveryOrdersState extends Equatable {
  final String status;
  final List<DeliverOrderModel> stockList;
  final List<DeliverOrderModel> deliveredList;
  final List<DeliverOrderModel> pendingList;
  const DeliveryOrdersState(
      {this.status = "initial",
      this.deliveredList = const [],
      this.pendingList = const [],
      this.stockList = const []});

  @override
  List<Object> get props => [
        status,
        stockList,
        deliveredList,
        pendingList,
      ];
}

class DeliveryOrdersInitial extends DeliveryOrdersState {
  const DeliveryOrdersInitial() : super();
}

class DeliveryOrdersScanning extends DeliveryOrdersState {
  const DeliveryOrdersScanning() : super(status: "scanning");
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

class ErrorOccurred extends DeliveryOrdersState {
   const ErrorOccurred() : super(status: "error");
}
