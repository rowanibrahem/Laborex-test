// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryOrderModel _$DeliveryOrderFromJson(Map<String, dynamic> json) =>
    DeliveryOrderModel(
      orderId: json['orderId'] as String,
      pharmacyName: json['pharmacyName'] as String,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      billNumber: json['billNumber'] as int,
      itemsCount: json['itemsCount'] as int,
      status:
          $enumDecodeNullable(_$DeliveryOrderStatusEnumMap, json['status']) ??
              DeliveryOrderStatus.inStock,
    );

Map<String, dynamic> _$DeliveryOrderToJson(DeliveryOrderModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'pharmacyName': instance.pharmacyName,
      'billNumber': instance.billNumber,
      'totalAmount': instance.totalAmount,
      'itemsCount': instance.itemsCount,
      'status': _$DeliveryOrderStatusEnumMap[instance.status]!,
    };

const _$DeliveryOrderStatusEnumMap = {
  DeliveryOrderStatus.inStock: 'inStock',
  DeliveryOrderStatus.pending: 'pending',
  DeliveryOrderStatus.delivered: 'delivered',
};
