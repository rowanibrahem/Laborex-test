import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'deliveryorders_state.dart';

class DeliveryordersCubit extends Cubit<DeliveryordersState> {
  DeliveryordersCubit() : super(DeliveryordersInitial());
}
