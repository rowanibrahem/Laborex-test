import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laborex_distribution_app/data/models/deliver_order_model.dart';
import 'package:laborex_distribution_app/presentation/cubit/authentication_cubit.dart';
import 'package:laborex_distribution_app/presentation/widgets/delivery_order_card.dart';

import '../cubit/delivery_orders_cubit.dart';

class RefreshableOrdersListView extends StatelessWidget {
  final List<DeliverOrderModel> orderList;

  /// The action to be performed when an item is tapped.
  /// first parameter [itemId] is the id of the tapped item (String).
  /// second parameter [index] is the index of the tapped item in the list (int).
  final void Function(String itemId, int index)? onTapAction;

  /// Creates a [RefreshableOrdersListView] with an empty list of orders.
  const RefreshableOrdersListView.empty({
    super.key,
  })  : orderList = const [],
        onTapAction = null;

  Future<void> _refreshData(BuildContext ctx) async {
    Future<void>.delayed(const Duration(seconds: 0));
    BlocProvider.of<DeliveryOrdersCubit>(ctx).fetchOrders(
      token: BlocProvider.of<AuthenticationCubit>(ctx).state.token!,
      tenantUUID: BlocProvider.of<AuthenticationCubit>(ctx).state.tenantUUID!,
    );
  }

  const RefreshableOrdersListView({
    super.key,
    required this.onTapAction,
    required this.orderList,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshData(context),
      child: (orderList.isEmpty)
          ? Stack(
              children: <Widget>[
                ListView(),
                const Center(
                  child: Text('لا يوجد طلبات هنا'),
                ),
              ],
            )
          : ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (_, int index) {
                return DeliveryOrderCard(
                  deliveryOrder: orderList[index],
                  onTapAction: (itemId) => onTapAction!(itemId, index),
                );
              },
            ),
    );
  }
}
