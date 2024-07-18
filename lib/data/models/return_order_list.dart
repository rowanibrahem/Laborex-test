import 'dart:convert';

import 'package:equatable/equatable.dart';

enum ReturnedOrderStatus { pending, returned, unhandled}

ReturnedOrderStatus parseOrderStatus(String status) {
  if (status == 'PENDING') {
    return ReturnedOrderStatus.pending;
  } else if (status == 'RETURNED') {
    return ReturnedOrderStatus.returned;

  }else{
    return ReturnedOrderStatus.unhandled;
  }
}

class ReturnOrderList extends Equatable {
  final int? returnedItems;
  final double? returnedAmount;
  final String? createdAt;
  final String? acceptedAt;
  final ReturnedOrderStatus? status;
  const ReturnOrderList({this.returnedAmount,this.returnedItems, this.createdAt, this.acceptedAt, this.status,});

  factory ReturnOrderList.fromMap(Map<String, dynamic> data) {
    return ReturnOrderList(
      returnedItems: data['returnedItems'] as int?,
      returnedAmount: data['returnedAmount'] as double?,
      createdAt: data['createdAt'] as String?,
      acceptedAt: data['acceptedAt'] as String?,
      status: parseOrderStatus(data['status'] as String)
    );
  }

  Map<String, dynamic> toMap() => {
    'returnedItems': returnedItems,
    'returnedAmount': returnedAmount,
   'createdAt': createdAt,
    'acceptedAt': acceptedAt,
    'status': status
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderDescriptionList].
  factory ReturnOrderList.fromJson(String data) {
    return ReturnOrderList.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderDescriptionList] to a JSON string.
  String toJson() => json.encode(toMap());

  ReturnOrderList copyWith({
     int? returnedItems,
     double? returnedAmount,
     String? createdAt,
     String? acceptedAt,
     ReturnedOrderStatus? status
  }) {
    return ReturnOrderList(
      returnedItems: returnedItems?? this.returnedItems,
    returnedAmount: returnedAmount?? this.returnedAmount,
    createdAt: createdAt?? this.createdAt,
    acceptedAt: acceptedAt?? this.acceptedAt,
      status: status?? this.status
    );
  }

  @override
  List<Object?> get props =>
      [returnedItems, returnedAmount, createdAt, acceptedAt, status];
}
