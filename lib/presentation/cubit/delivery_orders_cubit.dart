import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laborex_distribution_app/data/data%20source/remote_repo.dart';

import '../../data/models/deliver_order_model.dart';

part 'delivery_orders_state.dart';

class DeliveryOrdersCubit extends Cubit<DeliveryOrdersState> {
  RemoteRepo? remoteRepo;
  DeliveryOrdersCubit({
    this.remoteRepo,
  }) : super(const DeliveryOrdersInitial());
  // DeliveryOrdersCubit({
  //   required this.remoteRepo,
  // }) : super(const DeliveryOrdersInitial());

  List<DeliverOrderModel> orders = [];
  List<DeliverOrderModel> stockList = [];
  List<DeliverOrderModel> deliveredList = [];
  List<DeliverOrderModel> pendingList = [];

  void setDependencies(RemoteRepo repo) {
    remoteRepo = repo;
  }

  void startScan() {
    emit(const DeliveryOrdersScanning());

    ///TODO:IMPLEMENT FUN
    String id = 'barcode.code';
    addOrder(id);
    // emit(ScanedOrder());
    // getAllData(token);
    // emit(RefreshData());
  }

  addOrder(String id) {}

  // Future<List<DeliverOrderModel>> getAllData(String token) async {
  //   emit(LoadingState());

  //   var time = await Future(() => const Duration(seconds: 12));
  //   var indexOfBarcode = orders.first as List<DeliverOrderModel>;
  //   return indexOfBarcode;
  // }

  Future<void> getOrders(String token) async {
    //needed to make sure dio and apiService are initialized first

    emit(const LoadingState());

    try {
      List<DeliverOrderModel> allDeliveryOrders =
          await remoteRepo!.getOrders(token);
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
      //TODO handle error routine
      emit(const ErrorOccurred());
    }
  }
}
