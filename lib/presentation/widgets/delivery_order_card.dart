import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/presentation/widgets/bottom_section.dart';

import '../../data/models/deliver_order_model.dart';

class DeliveryOrderCard extends StatefulWidget {
  final DeliverOrderModel deliveryOrder;
  final void Function(String) onTapAction;

  const DeliveryOrderCard(
      {super.key, required this.deliveryOrder, required this.onTapAction});

  @override
  State<DeliveryOrderCard> createState() => _DeliveryOrderCardState();
}

class _DeliveryOrderCardState extends State<DeliveryOrderCard> {
  final String _scanBarcode = 'Unknown';
  final bool _foundResult = false;

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
              // trailing: Text(deliveryOrder.status.toString()),
              trailing: InkWell(
                child: (widget.deliveryOrder.orderStatus == OrderStatus.inStock)
                    ? Image.asset(
                        "assets/icons/qr_red.png",
                      )
                    : (widget.deliveryOrder.orderStatus ==
                            OrderStatus.inProgress)
                        ? Image.asset("assets/icons/qr_green.png")
                        : Image.asset("assets/icons/green_arrow.png"),
                onTap: () {
                  widget.onTapAction(widget.deliveryOrder.orderId.toString());
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
        ],
      ),
    );
  }
}

