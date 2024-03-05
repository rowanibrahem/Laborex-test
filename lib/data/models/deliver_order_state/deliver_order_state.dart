import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'order_description_list.dart';

class DeliverOrderStateModel extends Equatable {
	final int? orderId;
	final int? clientId;
	final String? clientName;
	final int? clientCode;
	final int? driverId;
	final String? driverName;
	final int? billNumber;
	final int? billTotalPrice;
	final int? numberOfItems;
	final DateTime? createdAt;
	final DateTime? deliveryStartAt;
	final DateTime? deliveredAt;
	final String? lineName;
	final String? orderStatus;
	final List<OrderDescriptionList>? orderDescriptionList;

	const DeliverOrderStateModel({
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
		this.orderStatus, 
		this.orderDescriptionList, 
	});

	factory DeliverOrderStateModel.fromMap(Map<String, dynamic> data) {
		return DeliverOrderStateModel(
			orderId: data['orderId'] as int?,
			clientId: data['clientId'] as int?,
			clientName: data['clientName'] as String?,
			clientCode: data['clientCode'] as int?,
			driverId: data['driverId'] as int?,
			driverName: data['driverName'] as String?,
			billNumber: data['billNumber'] as int?,
			billTotalPrice: data['billTotalPrice'] as int?,
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
			orderStatus: data['orderStatus'] as String?,
			orderDescriptionList: (data['orderDescriptionList'] as List<dynamic>?)
						?.map((e) => OrderDescriptionList.fromMap(e as Map<String, dynamic>))
						.toList(),
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
				'orderDescriptionList': orderDescriptionList?.map((e) => e.toMap()).toList(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DeliverOrderStateModel].
	factory DeliverOrderStateModel.fromJson(String data) {
		return DeliverOrderStateModel.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [DeliverOrderStateModel] to a JSON string.
	String toJson() => json.encode(toMap());

	DeliverOrderStateModel copyWith({
		int? orderId,
		int? clientId,
		String? clientName,
		int? clientCode,
		int? driverId,
		String? driverName,
		int? billNumber,
		int? billTotalPrice,
		int? numberOfItems,
		DateTime? createdAt,
		DateTime? deliveryStartAt,
		DateTime? deliveredAt,
		String? lineName,
		String? orderStatus,
		List<OrderDescriptionList>? orderDescriptionList,
	}) {
		return DeliverOrderStateModel(
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
		];
	}
}
