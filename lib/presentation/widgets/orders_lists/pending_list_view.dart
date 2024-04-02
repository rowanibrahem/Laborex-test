import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laborex_distribution_app/presentation/cubit/authentication_cubit.dart';
import 'package:laborex_distribution_app/presentation/cubit/delivery_orders_cubit.dart';
import 'package:laborex_distribution_app/presentation/widgets/custom_bottom_sheet.dart';
import 'package:laborex_distribution_app/presentation/widgets/refreshable_orders_list_view.dart';

class PendingListView extends StatelessWidget {
  const PendingListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deliveryOrdersCubit =
        BlocProvider.of<DeliveryOrdersCubit>(context, listen: true);

    final pendingList = deliveryOrdersCubit.pendingList;

    return (pendingList.isEmpty)
        ? const RefreshableOrdersListView.empty()
        : RefreshableOrdersListView(
            orderList: pendingList,
            onTapAction: (itemId, _) {
              Scaffold.of(context).showBottomSheet(
                (context) {
                  return CustomBottomSheet(
                    onConfirm: (
                      String paymentType,
                      String returnType,
                      String description,
                    ) {
                      deliveryOrdersCubit.deliveredAction(
                        token: BlocProvider.of<AuthenticationCubit>(context)
                            .state
                            .token!,
                        id: itemId,
                        paymentType: paymentType,
                        returnType: returnType,
                        description: description,
                      );
                    },
                  );
                },
              );
            },
          );
  }
}
