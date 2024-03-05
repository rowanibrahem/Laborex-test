import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laborex_distribution_app/data/models/deliver_order_state/deliver_order_state.dart';

part 'deliveryorders_state.dart';

class DeliveryordersCubit extends Cubit<DeliveryordersState> {
  DeliveryordersCubit() : super(DeliveryordersInitial());

  List<DeliverOrderStateModel> orders = [];

  startScan() {

    emit(DeliveryordersScanning());

    ///TODO:IMPLEMENT FUN
    String id = 'barcode.code';
    addOrder(id);
    // emit(ScanedOrder());
    // getAllData(token);
    // emit(RefreshData());
  }

  addOrder(String id) {}
  Future<List<DeliverOrderStateModel>> getAllData(String token) async {
    emit(LoadingData());

    var time = await Future(() => const Duration(seconds: 12));
    var indexOfBarcode = orders.first as List<DeliverOrderStateModel>;
    return indexOfBarcode;
  }
}
