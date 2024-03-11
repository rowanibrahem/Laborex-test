import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrderDescriptionList extends Equatable {
	final int? id;
	final String? paymentType;
	final String? returnType;
	final String? description;

	const OrderDescriptionList({
		this.id, 
		this.paymentType, 
		this.returnType, 
		this.description, 
	});

	factory OrderDescriptionList.fromMap(Map<String, dynamic> data) {
		return OrderDescriptionList(
			id: data['id'] as int?,
			paymentType: data['paymentType'] as String?,
			returnType: data['returnType'] as String?,
			description: data['description'] as String?,
		);
	}



	Map<String, dynamic> toMap() => {
				'id': id,
				'paymentType': paymentType,
				'returnType': returnType,
				'description': description,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderDescriptionList].
	factory OrderDescriptionList.fromJson(String data) {
		return OrderDescriptionList.fromMap(json.decode(data) as Map<String, dynamic>);
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
			description: description ?? this.description,
		);
	}

	@override
	List<Object?> get props => [id, paymentType, returnType, description];
}
