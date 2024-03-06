import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laborex_distribution_app/data/models/delivery_order.dart';

part 'deliveryorders_state.dart';

class DeliveryordersCubit extends Cubit<DeliveryordersState> {
  DeliveryordersCubit() : super(DeliveryordersInitial());

  List<DeliveryOrderModel> orders = [];

  startScan() {

    emit(DeliveryordersScanning());

    ///TODO:IMPLEMENT FUN
    String id = 'barcode.code';
    addOrder(id);
    // emit(ScanedOrder());
    // getAllData(token);
    // emit(RefreshData());
  }

  addOrder(String id ,) {}
  Future<List<DeliveryOrderModel>> getAllData(String token) async {
    emit(LoadingData());

    var time = await Future(() => const Duration(seconds: 12));
    var indexOfBarcode = orders.first as List<DeliveryOrderModel>;
    return indexOfBarcode;
  }
}
