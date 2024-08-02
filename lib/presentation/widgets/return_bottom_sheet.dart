import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laborex_distribution_app/core/enums.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/data/models/deliver_order_model.dart';
import 'package:laborex_distribution_app/presentation/cubit/authentication_cubit.dart';
import 'package:laborex_distribution_app/presentation/cubit/delivery_orders_cubit.dart';
import 'package:laborex_distribution_app/presentation/widgets/confirmation_dialog.dart';

class ReturnBottomSheet extends StatefulWidget {
  const ReturnBottomSheet({super.key, required this.item});

  final DeliverOrderModel item;

  @override
  State<ReturnBottomSheet> createState() => _ReturnBottomSheetState();
}

class _ReturnBottomSheetState extends State<ReturnBottomSheet> {
  ReturnType selectedReturn = ReturnType.partialReturn;
  final returnedAmountController = TextEditingController();
  final returnedItemsNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "حدد نوع المرتجع",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
          ),
          ListTile(
            title: const Text('مرتجع كلي'),
            leading: Radio<ReturnType>(
                value: ReturnType.fullReturn,
                groupValue: selectedReturn,
                onChanged: (ReturnType? value) {
                  setState(() {
                    selectedReturn = value!;
                  });
                }),
          ),
          ListTile(
            title: const Text('مرتجع جزئي'),
            leading: Radio<ReturnType>(
                value: ReturnType.partialReturn,
                groupValue: selectedReturn,
                onChanged: (ReturnType? value) {
                  setState(() {
                    selectedReturn = value!;
                  });
                }),
          ),
          Text(
            "أدخل قيمة المرتجع",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: returnedAmountController,
              decoration: InputDecoration(
                labelText: selectedReturn == ReturnType.fullReturn
                    ? widget.item.billTotalPrice.toString()
                    : 'ادخل قيمه المرتجع',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              enabled: selectedReturn == ReturnType.partialReturn,
            ),
          ),
          Text(
            "أدخل عدد أصناف المرتجع",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: returnedItemsNumController,
              decoration: InputDecoration(
                labelText: selectedReturn == ReturnType.fullReturn
                    ? widget.item.numberOfItems.toString()
                    : 'ادخل عدد الأصناف',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              enabled: selectedReturn == ReturnType.partialReturn,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => ConfirmationDialog(
                          text: 'تأكيد الطلب',
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text.rich(TextSpan(
                                  text: 'نوع المرتجع: ',
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: selectedReturn.arabicName,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ])),
                              Text.rich(TextSpan(
                                  text: 'مبلغ المرتجع: ',
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: selectedReturn ==
                                              ReturnType.fullReturn
                                          ? widget.item.billTotalPrice
                                              .toString()
                                          : returnedAmountController
                                                  .text.isEmpty
                                              ? '0'
                                              : returnedAmountController.text,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ])),
                              Text.rich(TextSpan(
                                  text: 'عدد أصناف المرتجع: ',
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: selectedReturn ==
                                              ReturnType.fullReturn
                                          ? widget.item.numberOfItems.toString()
                                          : returnedItemsNumController
                                                  .text.isEmpty
                                              ? '0'
                                              : returnedItemsNumController.text,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ])),
                            ],
                          ),
                          confirmationFunction: () {
                            BlocProvider.of<DeliveryOrdersCubit>(context)
                                .createReturn(
                              token:
                                  BlocProvider.of<AuthenticationCubit>(context)
                                      .state
                                      .token!,
                              tenantUUID:
                                  BlocProvider.of<AuthenticationCubit>(context)
                                      .state
                                      .tenantUUID!,
                              id: widget.item.orderId.toString(),
                              paymentType: widget
                                  .item.orderDescriptionList!.paymentType!,
                              returnType: selectedReturn.name,
                              returnedAmount: selectedReturn ==
                                      ReturnType.fullReturn
                                  ? widget.item.billTotalPrice!
                                  : double.parse(
                                      returnedAmountController.text.isNotEmpty
                                          ? returnedAmountController.text
                                          : '0'),
                              returnedItemsNum: selectedReturn ==
                                      ReturnType.fullReturn
                                  ? widget.item.numberOfItems!
                                  : int.parse(
                                      returnedAmountController.text.isNotEmpty
                                          ? returnedAmountController.text
                                          : '0'),
                            );
                            Navigator.pop(context);
                          },
                        ));
              },
              child: const Text('تأكيد'),
            ),
          )
        ],
      ),
    );
  }
}
