import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laborex_distribution_app/data/models/deliver_order_model.dart';
import 'package:laborex_distribution_app/presentation/cubit/authentication_cubit.dart';
import 'package:laborex_distribution_app/presentation/cubit/delivery_orders_cubit.dart';
import 'package:laborex_distribution_app/presentation/widgets/delivery_order_card.dart';

class TabViewsBuilder extends StatelessWidget {
  final TabController topTabController;
final  Future<void> refreshdata;
  final Function showsnackbar;
  const TabViewsBuilder({super.key,
  required this.topTabController,
   required this.refreshdata,
    required this.showsnackbar});

  @override

  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryOrdersCubit, DeliveryOrdersState>(
      builder: (context, state) {
        if (state.status == "loading") {
          return const LoadingView();
        } else {
          return TabViewsContent(
            topTabController: topTabController,
            state: state,
          );
        }
      },
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class TabViewsContent extends StatelessWidget {
  final TabController topTabController;
  final DeliveryOrdersState state;

  const TabViewsContent(
      {super.key, required this.topTabController, required this.state});

  @override
  Widget build(BuildContext context) {
    final deliveryOrdersCubit =
        BlocProvider.of<DeliveryOrdersCubit>(context, listen: true);

    return TabBarView(
      controller: topTabController,
      children: [
        StockListView(deliveryOrdersCubit: deliveryOrdersCubit),
        PendingListView(deliveryOrdersCubit: deliveryOrdersCubit),
        DeliveredList(deliveryOrdersCubit: deliveryOrdersCubit),
      ],
    );
  }
}

class StockListView extends StatelessWidget {
  final DeliveryOrdersCubit deliveryOrdersCubit;

  const StockListView({super.key, required this.deliveryOrdersCubit});

  @override
  Widget build(BuildContext context) {
    final stockList = deliveryOrdersCubit.stockList;

    return (stockList.isEmpty)
        ? const EmptyListView()
        : RefreshableListView(
            deliveryOrdersCubit: deliveryOrdersCubit,
            orderList: stockList,
          );
  }
}

class PendingListView extends StatelessWidget {
  final DeliveryOrdersCubit deliveryOrdersCubit;

  const PendingListView(
      {super.key,
      required this.deliveryOrdersCubit,
      this.refresh,
      this.snackbar});

  final Function? refresh;
  final Function? snackbar;
  @override
  Widget build(BuildContext context) {
    final pendingList = deliveryOrdersCubit.pendingList;

    return (pendingList.isEmpty)
        ? const EmptyListView()
        : RefreshableListView(
            refreshData: refresh,
            showSnackBar: snackbar,
            deliveryOrdersCubit: deliveryOrdersCubit,
            orderList: pendingList,
          );
  }
}

class DeliveredList extends StatelessWidget {
  final DeliveryOrdersCubit deliveryOrdersCubit;

  const DeliveredList({super.key, required this.deliveryOrdersCubit});

  @override
  Widget build(BuildContext context) {
    final deliveredList = deliveryOrdersCubit.deliveredList;

    return (deliveredList.isEmpty)
        ? const EmptyListView()
        : RefreshableListView(
            deliveryOrdersCubit: deliveryOrdersCubit,
            orderList: deliveredList,
          );
  }
}

class EmptyListView extends StatelessWidget {
  final Function? refreshData;

  const EmptyListView({super.key, this.refreshData});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refreshData!(context),
      child: Stack(
        children: <Widget>[
          ListView(),
          const Center(
            child: Text('لا يوجد طلبات هنا'),
          ),
        ],
      ),
    );
  }
}

class RefreshableListView extends StatelessWidget {
  final DeliveryOrdersCubit deliveryOrdersCubit;
  final List<DeliverOrderModel> orderList;

  const RefreshableListView(
      {super.key,
      required this.deliveryOrdersCubit,
      required this.orderList,
      this.refreshData,
      this.showSnackBar});

  // ignore: unused_field
  final Function? refreshData;
  final Function? showSnackBar;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refreshData!(context),
      child: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (_, int index) {
          return DeliveryOrderCard(
            deliveryOrder: orderList[index],
            onTapAction: (itemId) =>
            deliveryOrdersCubit.inStockAction(
              token: BlocProvider.of<AuthenticationCubit>(context).state.token!,
              id: itemId,
              tenantUUID: BlocProvider.of<AuthenticationCubit>(context).state.tenantUUID!
            ),
          );
        },
      ),
    );
  }
}

