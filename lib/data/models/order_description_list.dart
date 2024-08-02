import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrderDescriptionList extends Equatable {
  final int? id;
  final String? paymentType;
  final String? returnType;
  final double? returnedAmount;
  final int? returnedItemsNum;

  const OrderDescriptionList(
      {this.id,
      this.paymentType,
      this.returnType,
      this.returnedAmount,
      this.returnedItemsNum});

  factory OrderDescriptionList.fromMap(Map<String, dynamic> data) {
    return OrderDescriptionList(
      id: data['id'] as int?,
      paymentType: data['paymentType'] as String?,
      returnType: data['returnType'] as String?,
      returnedAmount: data['returnedAmount'] as double?,
      returnedItemsNum: data['returnedItems'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'paymentType': paymentType,
        'returnType': returnType,
        'returnedAmount': returnedAmount,
        'returnedItems': returnedItemsNum
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderDescriptionList].
  factory OrderDescriptionList.fromJson(String data) {
    return OrderDescriptionList.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderDescriptionList] to a JSON string.
  String toJson() => json.encode(toMap());

  OrderDescriptionList copyWith({
    int? id,
    String? paymentType,
    String? returnType,
    String? description,
  }) {
    return OrderDescriptionList(
        id: id ?? this.id,
        paymentType: paymentType ?? this.paymentType,
        returnType: returnType ?? this.returnType,
        returnedAmount: returnedAmount ?? returnedAmount,
        returnedItemsNum: returnedItemsNum ?? returnedItemsNum);
  }

  @override
  List<Object?> get props =>
      [id, paymentType, returnType, returnedAmount, returnedItemsNum];
}
