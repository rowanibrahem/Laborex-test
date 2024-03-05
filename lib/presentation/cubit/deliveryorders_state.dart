part of 'deliveryorders_cubit.dart';

abstract class DeliveryordersState extends Equatable {
  const DeliveryordersState();

  @override
  List<Object> get props => [];
}

class DeliveryordersInitial extends DeliveryordersState {}

class DeliveryordersScanning extends DeliveryordersState {}


class LoadingData extends DeliveryordersState {}

class LoadedData extends DeliveryordersState {}
class ErrorOccured extends DeliveryordersState{}