import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laborex_distribution_app/presentation/cubit/authentication_cubit.dart';
import 'package:laborex_distribution_app/presentation/cubit/delivery_orders_cubit.dart';
import 'package:laborex_distribution_app/presentation/widgets/refreshable_orders_list_view.dart';

class StockListView extends StatelessWidget {
  const StockListView({super.key});

  @override
  Widget build(BuildContext context) {
    final deliveryOrdersCubit =
        BlocProvider.of<DeliveryOrdersCubit>(context, listen: true);

    final stockList = deliveryOrdersCubit.stockList;

    return (stockList.isEmpty)
        ? const RefreshableOrdersListView.empty()
        : RefreshableOrdersListView(
            onTapAction: (itemId, _) => deliveryOrdersCubit.inStockAction(
              token: BlocProvider.of<AuthenticationCubit>(context).state.token!,
              tenantUUID: BlocProvider.of<AuthenticationCubit>(context).state.tenantUUID!,
              id: itemId,
            ),
            orderList: stockList,
          );
  }
}
