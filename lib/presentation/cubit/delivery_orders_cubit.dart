import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laborex_distribution_app/core/errors/custom_error.dart';
import 'package:laborex_distribution_app/data/data%20source/remote_repo.dart';

import '../../data/models/deliver_order_model.dart';

part 'delivery_orders_state.dart';

class DeliveryOrdersCubit extends Cubit<DeliveryOrdersState> {
  RemoteRepo? _remoteRepo;
  DeliveryOrdersCubit({
    RemoteRepo? remoteRepo,
  })  : _remoteRepo = remoteRepo,
        super(const DeliveryOrdersInitial());

  List<DeliverOrderModel> stockList = [];
  List<DeliverOrderModel> deliveredList = [];
  List<DeliverOrderModel> pendingList = [];

  void setDependencies(RemoteRepo repo) {
    _remoteRepo = repo;
  }

  /// This function is called when an error occurs is no longer need to be handled
  ///  and emit the  next correct state.
  void errorHandled() {
    emit(
      LoadedState(
        stockList: stockList,
        deliveredList: deliveredList,
        pendingList: pendingList,
      ),
    );
  }

  /// This function is called to get the orders from the remote repo.
  /// It emits the [LoadingState] before fetching the orders and then emits the
  /// [LoadedState] with the new orders.
  Future<void> fetchOrders({
    required String token,
  }) async {
    //needed to make sure dio and apiService are initialized first

    emit(const LoadingState());

    try {
      List<DeliverOrderModel> allDeliveryOrders =
          await _remoteRepo!.getOrders(token);

      //*
      stockList = allDeliveryOrders
          .where((element) => element.orderStatus == OrderStatus.inStock)
          .toList();
      pendingList = allDeliveryOrders
          .where((element) => element.orderStatus == OrderStatus.inProgress)
          .toList();
      deliveredList = allDeliveryOrders
          .where((element) => element.orderStatus == OrderStatus.delivered)
          .toList();

      //*
      emit(LoadedState(
        stockList: stockList,
        deliveredList: deliveredList,
        pendingList: pendingList,
      ));
    } catch (e) {
      if (e is CustomError) {
        emit(ErrorOccurredState(customError: e));
      } else {
        //TODO maybe there is better options for other types of error
        rethrow;
      }
    }
  }
/// This function is called to perform the action of starting the delivery process.
  Future<void> inStockAction({
    required String token,
    required String id,
  }) async {
    emit(const LoadingState());
    try {
      final response = await _remoteRepo!.startDelivery(token, id);

      emit(ShowMessageState(message: response));
    } catch (e) {
      if (e is CustomError) {
        emit(ErrorOccurredState(customError: e));
      } else {
        rethrow;
      }
    }
    fetchOrders(
      token: token,
    );
  }
/// This function is called to perform the action of finishing the delivery process.
  Future<void> deliveredAction({
    required String token,
    required String id,
    required String paymentType,
    required String returnType,
    required String description,
  }) async {
    emit(const LoadingState());
    try {
      final response = await _remoteRepo!.finishOrder(
        token,
        id,
        paymentType,
        returnType,
        description,
      );
      emit(ShowMessageState(message: response));
    } catch (e) {
      if (e is CustomError) {
        emit(ErrorOccurredState(customError: e));
      } else {
        rethrow;
      }
    }

    fetchOrders(
      token: token,
    );
  }
}
