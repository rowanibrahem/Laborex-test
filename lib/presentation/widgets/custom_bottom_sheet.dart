import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/enums.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
    required this.onConfirm,
  });
  final Function(
    String paymentType,
    String returnType,
    String returnedAmount,
    String returnedItemsNum,
  ) onConfirm;

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
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "اختر طريقة الدفع",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                labelText: 'ادخل قيمه المرتجع',
                enabled: (selectedReturn != ReturnType.noReturn),
                hintText: (selectedReturn == ReturnType.noReturn)
                    ? "لا يوجد مرتجع "
                    : null,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
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
                labelText: 'ادخل عدد الأصناف',
                enabled: (selectedReturn != ReturnType.noReturn),
                hintText: (selectedReturn == ReturnType.noReturn)
                    ? "لا يوجد مرتجع "
                    : null,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(

              onPressed: () {
                widget.onConfirm(
                  selectedPayment.name,
                  selectedReturn.name,
                  returnedAmountController.text,
                  returnedItemsNumController.text
                );
                Navigator.pop(context);
              },
              child: const Text('تأكيد'),
            ),
          ),
        ]),
      ),
    );
  }
}
