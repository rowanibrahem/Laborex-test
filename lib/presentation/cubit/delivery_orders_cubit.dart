import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:laborex_distribution_app/data/data%20source/remote_repo.dart';

import '../../data/models/deliver_order_model.dart';

part 'delivery_orders_state.dart';

class DeliveryOrdersCubit extends Cubit<DeliveryOrdersState> {
  RemoteRepo? _remoteRepo;
  DeliveryOrdersCubit({
    RemoteRepo? remoteRepo,
  })  : _remoteRepo = remoteRepo,
        super(const DeliveryOrdersInitial());
  // DeliveryOrdersCubit({
  //   required this.remoteRepo,
  // }) : super(const DeliveryOrdersInitial());

  final List<DeliverOrderModel> _orders = [];
  List<DeliverOrderModel> stockList = [];
  List<DeliverOrderModel> deliveredList = [];
  List<DeliverOrderModel> pendingList = [];

  void setDependencies(RemoteRepo repo) {
    _remoteRepo = repo;
  }

  void startScan() {
    emit(const DeliveryOrdersScanning());

    ///TODO:IMPLEMENT scanning
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

  Future<void> getOrders({
    required String token,
    required void Function(String) showSnackBar,
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
      showSnackBar(e.toString());

      emit(const DeliveryOrdersInitial());
    }
  }

  Future<void> inStockAction({
    required String token,
    required String id,
    required void Function(String) showSnackBar,
  }) async {
    emit(const LoadingState());
    try {
      final response = await _remoteRepo!.startDelivery(token, id);

      showSnackBar(response);
    } catch (e) {
      showSnackBar(e.toString());
    }
    getOrders(token: token, showSnackBar: showSnackBar);
  }

  Future<void> deliveredAction({
    required String token,
    required String id,
    required String paymentType,
    required String returnType,
    required String description,
    required void Function(String) showSnackBar,
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
      showSnackBar(response);

    } catch (e) {
      showSnackBar(e.toString());
    }

    getOrders(token: token, showSnackBar: showSnackBar);
  }
}
