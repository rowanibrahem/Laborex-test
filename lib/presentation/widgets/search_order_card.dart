import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/data/models/return_order_list.dart';
import 'package:laborex_distribution_app/presentation/cubit/authentication_cubit.dart';
import 'package:laborex_distribution_app/presentation/cubit/delivery_orders_cubit.dart';
import 'package:laborex_distribution_app/presentation/widgets/bottom_section.dart';
import 'package:laborex_distribution_app/presentation/widgets/custom_bottom_sheet.dart';
import 'package:laborex_distribution_app/presentation/widgets/info_dialog.dart';
import 'package:laborex_distribution_app/presentation/widgets/orders_lists/custom_action_button.dart';

import '../../data/models/deliver_order_model.dart';

class SearchOrderCard extends StatefulWidget {
  final DeliverOrderModel deliveryOrder;
  final void Function(String) onTapAction;

  const SearchOrderCard(
      {super.key, required this.deliveryOrder, required this.onTapAction});

  @override
  State<SearchOrderCard> createState() => _SearchOrderCardState();
}

class _SearchOrderCardState extends State<SearchOrderCard> {
  @override
  Widget build(BuildContext context) {
    var customDivider = SizedBox(
      height: 34.h,
      child: VerticalDivider(
        color: Colors.grey[90],
        thickness: 1,
      ),
    );
    return Card(
      child: Column(
        children: [
          ListTile(
              title: Text(
                widget.deliveryOrder.clientName!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
              ),
              subtitle: Text(
                widget.deliveryOrder.orderId.toString(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14.sp,
                    ),
              ),
              trailing: CustomActionButton(
                status: widget.deliveryOrder.orderStatus,
                onPressed: () {
                  // widget.onTapAction(
                  //     widget.deliveryOrder.orderId.toString());
                  widget.deliveryOrder.orderStatus == OrderStatus.inStock
                      ? inStockAction(widget.deliveryOrder.orderId.toString())
                      : widget.deliveryOrder.orderStatus ==
                              OrderStatus.inProgress
                          ? pendingAction(
                              widget.deliveryOrder.orderId.toString())
                          : deliveredAction(
                              widget.deliveryOrder.orderId.toString(),
                              widget.deliveryOrder);
                },
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BottomSection(
                  title: "رقم الفاتورة",
                  subtitle: widget.deliveryOrder.billNumber.toString(),
                ),
                customDivider,
                BottomSection(
                  title: "التكلفة الكلية",
                  subtitle: widget.deliveryOrder.billTotalPrice.toString(),
                ),
                customDivider,
                BottomSection(
                  title: "عدد الاصناف",
                  subtitle: widget.deliveryOrder.numberOfItems.toString(),
                ),
              ],
            ),
          ),
          widget.deliveryOrder.orderStatus == OrderStatus.delivered
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                  child: MaterialButton(
                    onPressed: () => widget.deliveryOrder.returnOrderHistory==null?returnBottomSheet(widget.deliveryOrder.orderId.toString(),false): widget.deliveryOrder.returnOrderHistory!.status==ReturnedOrderStatus.pending?returnBottomSheet(widget.deliveryOrder.orderId.toString(),true):returnBottomSheet(widget.deliveryOrder.orderId.toString(),false),
                    color: Theme.of(context).primaryColor,
                    minWidth: double.infinity,
                    textColor: Colors.white,
                    child:Text(widget.deliveryOrder.returnOrderHistory==null?'طلب تعديل':'التفاصيل'),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  inStockAction(itemId) {
    BlocProvider.of<DeliveryOrdersCubit>(context).inStockAction(
      token: BlocProvider.of<AuthenticationCubit>(context).state.token!,
      tenantUUID:
          BlocProvider.of<AuthenticationCubit>(context).state.tenantUUID!,
      id: itemId,
    );
  }

  pendingAction(itemId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            CustomBottomSheet(
              onConfirm: (
                String paymentType,
                String returnType,
                String returnedAmount,
                String returnedItemsNum,
              ) {
                BlocProvider.of<DeliveryOrdersCubit>(context).deliveredAction(
                  token: BlocProvider.of<AuthenticationCubit>(context)
                      .state
                      .token!,
                  tenantUUID: BlocProvider.of<AuthenticationCubit>(context)
                      .state
                      .tenantUUID!,
                  id: itemId,
                  paymentType: paymentType,
                  returnType: returnType,
                  returnedAmount: returnedAmount.isNotEmpty
                      ? double.parse(returnedAmount)
                      : 0,
                  returnedItemsNum: returnedItemsNum.isNotEmpty
                      ? int.parse(returnedItemsNum)
                      : 0,
                );
              },
            )
          ],
        );
      },
    );
  }

  deliveredAction(itemId, order) {
    {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return InfoDialog(
              deliveryOrder: order,
            );
          });
    }
  }

  returnBottomSheet(itemId,bool isButtonInvisible) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            CustomBottomSheet(onConfirm: (
              String paymentType,
              String returnType,
              String returnedAmount,
              String returnedItemsNum,
            ) {
              BlocProvider.of<DeliveryOrdersCubit>(context).createReturn(
                token:
                    BlocProvider.of<AuthenticationCubit>(context).state.token!,
                tenantUUID: BlocProvider.of<AuthenticationCubit>(context)
                    .state
                    .tenantUUID!,
                id: itemId,
                paymentType: paymentType,
                returnType: returnType,
                returnedAmount: returnedAmount.isNotEmpty
                    ? double.parse(returnedAmount)
                    : 0,
                returnedItemsNum: returnedItemsNum.isNotEmpty
                    ? int.parse(returnedItemsNum)
                    : 0,
              );
            },buttonInvisible: isButtonInvisible,)
          ],
        );
      },
    );
  }
}
