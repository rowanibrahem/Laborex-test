import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:laborex_distribution_app/data/models/return_order_list.dart';

import 'order_description_list.dart';

enum OrderStatus { inStock, inProgress, delivered,cancelled }

OrderStatus parseOrderStatus(String status) {
  if (status == 'ORDER_CREATED') {
    return OrderStatus.inStock;
  } else if (status == 'IN_PROGRESS') {
    return OrderStatus.inProgress;
  } else if (status == 'DELIVERED') {
    return OrderStatus.delivered;
  }else{
    return OrderStatus.cancelled;
  }
}

class DeliverOrderModel extends Equatable {
  final int? orderId;
  final int? clientId;
  final String? clientName;
  final int? clientCode;
  final int? driverId;
  final String? driverName;
  final int? billNumber;
  final double? billTotalPrice;
  final int? numberOfItems;
  final DateTime? createdAt;
  final DateTime? deliveryStartAt;
  final DateTime? deliveredAt;
  final String? lineName;
  final OrderStatus orderStatus;
  final OrderDescriptionList? orderDescriptionList;
  final ReturnOrderList? returnOrderHistory;

  const DeliverOrderModel({
    this.orderId,
    this.clientId,
    this.clientName,
    this.clientCode,
    this.driverId,
    this.driverName,
    this.billNumber,
    this.billTotalPrice,
    this.numberOfItems,
    this.createdAt,
    this.deliveryStartAt,
    this.deliveredAt,
    this.lineName,
    required this.orderStatus,
    this.orderDescriptionList,
    this.returnOrderHistory
  });

  factory DeliverOrderModel.fromMap(Map<String, dynamic> data) {
    return DeliverOrderModel(
      orderId: data['orderId'] as int?,
      clientId: data['clientId'] as int?,
      clientName: data['clientName'] as String?,
      clientCode: data['clientCode'] as int?,
      driverId: data['driverId'] as int?,
      driverName: data['driverName'] as String?,
      billNumber: data['billNumber'] as int?,
      billTotalPrice: data['billTotalPrice'] as double?,
      numberOfItems: data['numberOfItems'] as int?,
      createdAt: data['createdAt'] == null
          ? null
          : DateTime.parse(data['createdAt'] as String),
      deliveryStartAt: data['deliveryStartAt'] == null
          ? null
          : DateTime.parse(data['deliveryStartAt'] as String),
      deliveredAt: data['deliveredAt'] == null
          ? null
          : DateTime.parse(data['deliveredAt'] as String),
      lineName: data['lineName'] as String?,
      orderStatus: parseOrderStatus(data['orderStatus'] as String),
      orderDescriptionList: (data['orderDescriptionList'] as List<dynamic>).isEmpty ? null : OrderDescriptionList.fromMap(
                  data['orderDescriptionList'][0]),
      returnOrderHistory: (data['returnOrderHistory'] as List<dynamic>).isEmpty ? null : ReturnOrderList.fromMap(
          data['returnOrderHistory'][data['returnOrderHistory'].length-1])

      // (data['orderDescriptionList'] as dynamic)
      //     ?.map((e) => OrderDescriptionList.fromMap(e as Map<String, dynamic>))
      //     ,
    );
  }

  Map<String, dynamic> toMap() => {
        'orderId': orderId,
        'clientId': clientId,
        'clientName': clientName,
        'clientCode': clientCode,
        'driverId': driverId,
        'driverName': driverName,
        'billNumber': billNumber,
        'billTotalPrice': billTotalPrice,
        'numberOfItems': numberOfItems,
        'createdAt': createdAt?.toIso8601String(),
        'deliveryStartAt': deliveryStartAt?.toIso8601String(),
        'deliveredAt': deliveredAt?.toIso8601String(),
        'lineName': lineName,
        'orderStatus': orderStatus,
        'orderDescriptionList':
            orderDescriptionList,
    'returnOrderHistory' : returnOrderHistory
      };

  /// Parses the string and returns the resulting Json object as [DeliverOrderModel].
  factory DeliverOrderModel.fromJson(String data) {
    return DeliverOrderModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// Converts [DeliverOrderModel] to a JSON string.
  String toJson() => json.encode(toMap());

  DeliverOrderModel copyWith({
    int? orderId,
    int? clientId,
    String? clientName,
    int? clientCode,
    int? driverId,
    String? driverName,
    int? billNumber,
    double? billTotalPrice,
    int? numberOfItems,
    DateTime? createdAt,
    DateTime? deliveryStartAt,
    DateTime? deliveredAt,
    String? lineName,
    OrderStatus? orderStatus,
  OrderDescriptionList? orderDescriptionList,
    ReturnOrderList? returnOrderHistory
  }) {
    return DeliverOrderModel(
      orderId: orderId ?? this.orderId,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientCode: clientCode ?? this.clientCode,
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
      billNumber: billNumber ?? this.billNumber,
      billTotalPrice: billTotalPrice ?? this.billTotalPrice,
      numberOfItems: numberOfItems ?? this.numberOfItems,
      createdAt: createdAt ?? this.createdAt,
      deliveryStartAt: deliveryStartAt ?? this.deliveryStartAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      lineName: lineName ?? this.lineName,
      orderStatus: orderStatus ?? this.orderStatus,
      orderDescriptionList: orderDescriptionList ?? this.orderDescriptionList,
      returnOrderHistory: returnOrderHistory?? this.returnOrderHistory
    );
  }

  @override
  List<Object?> get props {
    return [
      orderId,
      clientId,
      clientName,
      clientCode,
      driverId,
      driverName,
      billNumber,
      billTotalPrice,
      numberOfItems,
      createdAt,
      deliveryStartAt,
      deliveredAt,
      lineName,
      orderStatus,
      orderDescriptionList,
      returnOrderHistory
    ];
  }
}
