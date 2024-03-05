import '../../data/models/delivery_order.dart';

class DeliveryOrderRepository {
  // List of delivery orders
  List<DeliveryOrderModel> deliveryOrders;

  DeliveryOrderRepository() : deliveryOrders = _initializeDeliveryOrders();

  static List<DeliveryOrderModel> _initializeDeliveryOrders() {
    return [
      DeliveryOrderModel(
        orderId: "112213115",
        pharmacyName: "صيدلية بيراميدز",
        itemsCount: 2,
        billNumber: 1,
        totalAmount: 22.5,
        status: DeliveryOrderStatus.pending,
      ),
      DeliveryOrderModel(
        orderId: "264664",
        pharmacyName: "صيدلية بيراميدز",
        itemsCount: 3,
        billNumber: 2,
        totalAmount: 33.5,
        status: DeliveryOrderStatus.inStock,
      ),
      DeliveryOrderModel(
        orderId: "355531",
        pharmacyName: "صيدلية بيراميدز",
        itemsCount: 4,
        billNumber: 3,
        totalAmount: 44.5,
        status: DeliveryOrderStatus.delivered,
      ),
      DeliveryOrderModel(
        orderId: "6515513",
        pharmacyName: "Pasta",
        itemsCount: 4,
        billNumber: 3,
        totalAmount: 44.5,
        status: DeliveryOrderStatus.delivered,
      ),
      DeliveryOrderModel(
        orderId: "315151515",
        pharmacyName: "صيدلية بيراميدز",
        itemsCount: 4,
        billNumber: 3,
        totalAmount: 44.5,
        status: DeliveryOrderStatus.delivered,
      ),
    ];
    
  }

  Future<List<DeliveryOrderModel>> getDeliveryOrders() async {
    // Implement the logic to fetch data from your  (API)
    // For now, return a static list
    await Future.delayed(const Duration(seconds: 2));
    return deliveryOrders;
  }
}
