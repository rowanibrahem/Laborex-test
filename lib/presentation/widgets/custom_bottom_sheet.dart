import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/data/models/deliver_order_model.dart';
import 'package:laborex_distribution_app/presentation/widgets/confirmation_dialog.dart';

import '../../core/enums.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
    required this.onConfirm,
    required this.item,
  });

  final Function(
      String paymentType,
      String returnType,
      String returnedAmount,
      String returnedItemsNum,
      ) onConfirm;

  final DeliverOrderModel item;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  PaymentType selectedPayment = PaymentType.cash;
  ReturnType selectedReturn = ReturnType.noReturn;
  final returnedAmountController = TextEditingController();
  final returnedItemsNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 647.h,
      padding: EdgeInsets.all(24.w),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "اختر طريقة الدفع",
            style: Theme
                .of(context)
                .textTheme
                .titleSmall
                ?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          ListTile(
            title: const Text('فاتورة نقدا'),
            leading: Radio<PaymentType>(
                value: PaymentType.cash,
                groupValue: selectedPayment,
                onChanged: (PaymentType? value) {
                  setState(() {
                    selectedPayment = value!;
                  });
                }),
          ),
          ListTile(
            title: const Text('فاتورة بالختم'),
            leading: Radio<PaymentType>(
                value: PaymentType.payLater,
                groupValue: selectedPayment,
                onChanged: (PaymentType? value) {
                  setState(() {
                    selectedPayment = value!;
                  });
                }),
          ),
          Text(
            "حدد نوع المرتجع",
            style: Theme
                .of(context)
                .textTheme
                .titleSmall
                ?.copyWith(
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
          ListTile(
            title: const Text('لا يوجد مرتجع'),
            leading: Radio<ReturnType>(
                value: ReturnType.noReturn,
                groupValue: selectedReturn,
                onChanged: (ReturnType? value) {
                  setState(() {
                    selectedReturn = value!;
                  });
                }),
          ),
          Text(
            "أدخل قيمة المرتجع",
            style: Theme
                .of(context)
                .textTheme
                .titleSmall
                ?.copyWith(
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
            style: Theme
                .of(context)
                .textTheme
                .titleSmall
                ?.copyWith(
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
                showDialog(context: context, builder: (context) =>
                    ConfirmationDialog(
                      text:'تأكيد الطلب',
                      content:  Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      Text.rich(
                      TextSpan(
                      text: 'نوع الفاتورة: ',
                          children: <InlineSpan>[
                            TextSpan(
                              text: selectedPayment.arabicName,
                              style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                            )
                          ]
                      )),
                      Text.rich(
                      TextSpan(
                      text: 'نوع المرتجع: ',
                          children: <InlineSpan>[
                            TextSpan(
                              text: selectedReturn.arabicName,
                              style: const TextStyle(fontSize:16,fontWeight: FontWeight.bold),
                            )
                          ]
                      )),
                      Text.rich(
                      TextSpan(
                      text: 'مبلغ المرتجع: ',
                          children: <InlineSpan>[
                            TextSpan(
                              text: selectedReturn == ReturnType.fullReturn
                      ? widget.item.billTotalPrice.toString()
                              : returnedAmountController.text.isEmpty?'0':returnedAmountController.text,
                              style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                            )
                          ]
                      )),
                      Text.rich(
                      TextSpan(
                      text: 'عدد أصناف المرتجع: ',
                          children: <InlineSpan>[
                            TextSpan(
                              text: selectedReturn == ReturnType.fullReturn
                      ? widget.item.numberOfItems.toString()
                              : returnedItemsNumController.text.isEmpty?'0':returnedItemsNumController.text,
                              style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                            )
                          ]
                      )),
                        ],
                      ),
                      confirmationFunction: () {
                      widget.onConfirm(
                          selectedPayment.name,
                          selectedReturn.name,
                          selectedReturn == ReturnType.fullReturn
                              ? widget.item.billTotalPrice.toString()
                              : returnedAmountController.text,
                          selectedReturn == ReturnType.fullReturn
                              ? widget.item.numberOfItems.toString()
                              : returnedItemsNumController.text);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },));
              },
              child: const Text('تأكيد'),
            ),
          ),
        ]),
      ),
    );
  }
}