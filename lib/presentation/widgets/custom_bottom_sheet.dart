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
    String description,
  ) onConfirm;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  PaymentType selectedPayment = PaymentType.cash;
  ReturnType selectedReturn = ReturnType.noReturn;
  final descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
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
            onChanged: (e){print(e);
              print(descriptionController.text);
              },
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'ادخل تفاصيل المرتجع',
              enabled: (selectedReturn != ReturnType.noReturn),
              hintText: (selectedReturn == ReturnType.noReturn)
                  ? "لا يوجد مرتجع "
                  : null,
              border: const OutlineInputBorder(),
            ),
            minLines: 2,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(

              onPressed: () {
                print(descriptionController.text);
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
    );
  }
}
