

// TODO need to be removed, but left for testing purposes
//   TODO  until release 


// import '../models/deliver_order_model.dart';

// class DeliveryOrderRepository {
//   // List of delivery orders
//   List<DeliverOrderModel> deliveryOrders;

//   DeliveryOrderRepository() : deliveryOrders = _initializeDeliveryOrders();

//   static List<DeliverOrderModel> _initializeDeliveryOrders() {
//     return [
//       const DeliverOrderModel(
//         orderId: 112213115,
//         clientId: 1,
//         clientName: "John Doe",

//         // pharmacyName: "صيدلية بيراميدز",
//         // itemsCount: 2,
//         billNumber: 1,
//         //totalAmount: 22.5,
//         //status: DeliveryOrderStatus.pending,
//       ),
//       const DeliverOrderModel(orderId: 264664, orderStatus: 'جار التوصيل'
//           //pharmacyName: "صيدلية بيراميدز",
//           ),
//       const DeliverOrderModel(
//         orderId: 355531,

//         //orderStatus: DeliverOrderStateModel.fromJson(data).orderStatus,
//       ),
//       const DeliverOrderModel(
//           // orderId: "6515513",
//           // pharmacyName: "Pasta",
//           // itemsCount: 4,
//           // billNumber: 3,
//           // totalAmount: 44.5,
//           // status: DeliveryOrderStatus.delivered,
//           ),
//       const DeliverOrderModel(
//           // orderId: "315151515",
//           // pharmacyName: "صيدلية بيراميدز",
//           // itemsCount: 4,
//           // billNumber: 3,
//           // totalAmount: 44.5,
//           // status: DeliveryOrderStatus.delivered,
//           ),
//     ];
//   }

//   Future<List<DeliverOrderModel>> getDeliveryOrders() async {
//     // Implement the logic to fetch data from your  (API)
//     // For now, return a static list
//     await Future.delayed(const Duration(seconds: 2));
//     return deliveryOrders;
//   }
// }
