import 'package:flutter/material.dart';
import 'package:laborex_distribution_app/presentation/widgets/centered_loading.dart';
import 'package:laborex_distribution_app/presentation/widgets/orders_lists/delivered_list.dart';
import 'package:laborex_distribution_app/presentation/widgets/orders_lists/pending_list_view.dart';
import 'package:laborex_distribution_app/presentation/widgets/orders_lists/stock_list_view.dart';

class TabViewsContent extends StatelessWidget {
  final TabController topTabController;
  final bool isLoading;

  const TabViewsContent({super.key, required this.topTabController})
      : isLoading = false;
  const TabViewsContent.loading({super.key, required this.topTabController})
      : isLoading = true;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: topTabController,
      children: (isLoading)
          ? [
              const CenteredLoading(),
              const CenteredLoading(),
              const CenteredLoading(),
            ]
          : const [
              StockListView(),
              PendingListView(),
              DeliveredList(),
            ],
    );
  }
}
