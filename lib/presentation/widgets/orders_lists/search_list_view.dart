import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laborex_distribution_app/presentation/cubit/delivery_orders_cubit.dart';
import 'package:laborex_distribution_app/presentation/widgets/refreshable_orders_list_view.dart';

class SearchListView extends StatelessWidget {
  const SearchListView({super.key});
  @override
  Widget build(BuildContext context) {
    var deliveryOrdersCubit =
    BlocProvider.of<DeliveryOrdersCubit>(context, listen: true);

    var filteredOrders = deliveryOrdersCubit.filteredOrders;

    return (filteredOrders.isEmpty)
        ? const RefreshableOrdersListView.empty()
        : RefreshableOrdersListView(
      onTapAction: (itemId, _){},
      orderList: filteredOrders,
      isSearchScreen: true,
    );
  }
}
