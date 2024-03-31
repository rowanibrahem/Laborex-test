import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/core/enums.dart';
import 'package:laborex_distribution_app/data/models/deliver_order_model.dart';
import 'package:laborex_distribution_app/presentation/widgets/bottom_section.dart';

class InfoDialog extends StatefulWidget {
  const InfoDialog({super.key, required this.deliveryOrder});

  final DeliverOrderModel deliveryOrder;

  @override
  State<InfoDialog> createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  @override
  Widget build(BuildContext context) {
    var customDivider = SizedBox(
      height: 34.h,
      child: VerticalDivider(
        color: Colors.grey[90],
        thickness: 1,
      ),
    );
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: Container(
        color: Theme.of(context).colorScheme.secondary,
        width: 390.w,
        height: 442.h,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'التفاصيل',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20.sp,
                      ),
                ),
                trailing: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset('assets/icons/gg_close-o.png')),
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${widget.deliveryOrder.clientName}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      widget.deliveryOrder.orderId.toString(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14.sp,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                constraints: BoxConstraints(
                  maxWidth: 390.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: ListTile(
                        title: SizedBox(
                          width: 100.w,
                          child: Text(
                            'نوع المرتجع',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xbb696969),
                                  fontSize: 14.sp,
                                ),
                          ),
                        ),
                        subtitle: SizedBox(
                          width: 100.w,
                          child: Text(
                            ReturnTypeExtension.fromString(widget
                                        .deliveryOrder
                                        .orderDescriptionList!
                                        .first
                                        .returnType!)
                                    ?.arabicName ??
                                "غير معروف",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14.sp,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: null,
                        child: Text(
                          PaymentTypeExtension.fromString(widget.deliveryOrder
                                      .orderDescriptionList!.first.paymentType!)
                                  ?.arabicName ??
                              "غير معروف",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "تفاصل المرتجع",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xbb696969),
                        fontSize: 14.sp,
                      ),
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                    (widget.deliveryOrder.orderDescriptionList?.first
                            .description) ??
                        "لا يوجد تفاصيل",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 14.sp,
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

