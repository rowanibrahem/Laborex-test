import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laborex_distribution_app/presentation/cubit/delivery_orders_cubit.dart';
import 'package:laborex_distribution_app/presentation/widgets/info_dialog.dart';
import 'package:laborex_distribution_app/presentation/widgets/refreshable_orders_list_view.dart';

class DeliveredList extends StatelessWidget {
  const DeliveredList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deliveryOrdersCubit =
        BlocProvider.of<DeliveryOrdersCubit>(context, listen: true);

    final deliveredList = deliveryOrdersCubit.deliveredList;

    return (deliveredList.isEmpty)
        ? const RefreshableOrdersListView.empty()
        : RefreshableOrdersListView(
            orderList: deliveredList,
            onTapAction: (String itemId, int index) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return InfoDialog(
                      deliveryOrder: deliveredList[index],
                    );
                  });
            },
          );
  }
}
