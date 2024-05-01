import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/deliver_order_model.dart';

class CustomActionButton extends StatelessWidget {
  final OrderStatus status;
  final VoidCallback onPressed;

  const CustomActionButton({
    super.key,
    required this.status,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: (status == OrderStatus.delivered)
            ? MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(
                  0.0,
                ),
              )
            : MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
              ),
        backgroundColor: MaterialStateProperty.all<Color>(
          (status == OrderStatus.inStock)
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.primary,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      child: (status == OrderStatus.delivered)
          ? Icon(
              Icons.more_horiz,
              size: 48.sp,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          : Text(
              (status == OrderStatus.inStock) ? "تم الإستلام" : "تم التوصيل",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
    );
  }
}
