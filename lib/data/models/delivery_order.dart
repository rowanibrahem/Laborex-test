import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_order.g.dart';

enum DeliveryOrderStatus {
  inStock,
  pending,
  delivered,
}

@JsonSerializable()
class DeliveryOrderModel extends Equatable {
  final String orderId;
  final String pharmacyName;
  final int billNumber;
  final double totalAmount;
  final int itemsCount;

  DeliveryOrderStatus status;

  DeliveryOrderModel({
    required this.orderId,
    required this.pharmacyName,
    required this.totalAmount,
    required this.billNumber,
    required this.itemsCount,
    this.status = DeliveryOrderStatus.inStock,
  });

  void updateStatus(DeliveryOrderStatus newStatus) {
    status = newStatus;
  }

  factory DeliveryOrderModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryOrderFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryOrderToJson(this);

  @override
  List<Object?> get props =>
      [orderId, pharmacyName, totalAmount, billNumber, itemsCount];
}
