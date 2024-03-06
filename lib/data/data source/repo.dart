import 'package:laborex_distribution_app/data/models/deliver_order_state/deliver_order_state.dart';

class DeliveryOrderRepository {
  // List of delivery orders
  List<DeliverOrderStateModel> deliveryOrders;

  DeliveryOrderRepository() : deliveryOrders = _initializeDeliveryOrders();

  static List<DeliverOrderStateModel> _initializeDeliveryOrders() {
    return [
      const DeliverOrderStateModel(
        orderId: 112213115,
        clientId: 1,
        clientName: "John Doe",

        // pharmacyName: "صيدلية بيراميدز",
        // itemsCount: 2,
        billNumber: 1,
        //totalAmount: 22.5,
        //status: DeliveryOrderStatus.pending,
      ),
      const DeliverOrderStateModel(orderId: 264664, orderStatus: 'جار التوصيل'
          //pharmacyName: "صيدلية بيراميدز",
          ),
      const DeliverOrderStateModel(
        orderId: 355531,

        //orderStatus: DeliverOrderStateModel.fromJson(data).orderStatus,
      ),
      const DeliverOrderStateModel(
          // orderId: "6515513",
          // pharmacyName: "Pasta",
          // itemsCount: 4,
          // billNumber: 3,
          // totalAmount: 44.5,
          // status: DeliveryOrderStatus.delivered,
          ),
      const DeliverOrderStateModel(
          // orderId: "315151515",
          // pharmacyName: "صيدلية بيراميدز",
          // itemsCount: 4,
          // billNumber: 3,
          // totalAmount: 44.5,
          // status: DeliveryOrderStatus.delivered,
          ),
    ];
  }

  Future<List<DeliverOrderStateModel>> getDeliveryOrders() async {
    // Implement the logic to fetch data from your  (API)
    // For now, return a static list
    await Future.delayed(const Duration(seconds: 2));
    return deliveryOrders;
  }
}
