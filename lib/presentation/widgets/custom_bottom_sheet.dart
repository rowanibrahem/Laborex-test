import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/presentation/screens/home_screen.dart';

import '../../core/enums.dart';

class CustomBottomSheet extends StatefulWidget {
   CustomBottomSheet({
    super.key,
    required this.onConfirm,
  });
  Function(
    String paymentType,
    String returnType,
    String description,
  ) onConfirm;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}


class _CustomBottomSheetState extends State<CustomBottomSheet> {
  PaymentType selectedPayment = PaymentType.cash;
  ReturnType selectedReturn = ReturnType.noReturn;

  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();
    return Material(
      elevation: 50, // Adjust elevation for shadow height
      shadowColor: Colors.black,
      // Optional: Customize shadow color

      child: Container(
        height: 647.h,
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
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'ادخل تفاصيل المرتجع',
                border: OutlineInputBorder(),
              ),
              minLines: 2,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  widget.onConfirm(
                    selectedPayment.name,
                    selectedReturn.name,
                    descriptionController.text,
                  );
                  Navigator.pop(context);
                },
                child: const Text('تأكيد'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
