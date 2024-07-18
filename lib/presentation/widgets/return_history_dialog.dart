import 'package:flutter/material.dart';
import 'package:laborex_distribution_app/data/models/deliver_order_model.dart';
import 'package:laborex_distribution_app/data/models/return_order_list.dart';

class ReturnHistoryDialog extends StatelessWidget {
  final DeliverOrderModel deliveryOrder;

  const ReturnHistoryDialog({super.key, required this.deliveryOrder});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  deliveryOrder.returnOrderHistory!.isNotEmpty
                      ? "سجل المرتجعات"
                      : "لا يوجد طلبات مرتجع",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              deliveryOrder.returnOrderHistory!.isNotEmpty
                  ? const Divider(
                      thickness: 2,
                      color: Colors.green,
                    )
                  : const SizedBox(),
              deliveryOrder.returnOrderHistory!.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "العدد",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "الاجمالي",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "الحاله",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    )
                  : const SizedBox(),
              deliveryOrder.returnOrderHistory!.isNotEmpty
                  ? const Divider()
                  : const SizedBox(),
              SizedBox(
                // height: 250.h,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: deliveryOrder.returnOrderHistory!.length,
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(deliveryOrder
                          .returnOrderHistory![index].returnedItems
                          .toString()),
                      Text(deliveryOrder
                          .returnOrderHistory![index].returnedAmount
                          .toString()),
                      Text(
                        deliveryOrder.returnOrderHistory![index].status ==
                                ReturnedOrderStatus.pending
                            ? "جاري المراجعه"
                            : deliveryOrder.returnOrderHistory![index].status ==
                                    ReturnedOrderStatus.returned
                                ? "مقبول"
                                : "مرفوض",
                        style: TextStyle(
                            color: deliveryOrder
                                        .returnOrderHistory![index].status ==
                                    ReturnedOrderStatus.pending
                                ? Colors.yellowAccent[700]
                                : deliveryOrder.returnOrderHistory![index]
                                            .status ==
                                        ReturnedOrderStatus.returned
                                    ? Colors.green
                                    : Colors.red),
                      ),
                    ],
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
