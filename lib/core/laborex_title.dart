import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Widget> laborexTitle(BuildContext ctx)
{
return [
  Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 24.w,
      //vertical: 16.h
    ),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Laborex',
            style: Theme.of(ctx).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.sp,
                  color: Theme.of(ctx).colorScheme.primary,
                ),
          ),
          Text(
            'Pharma',
            style: Theme.of(ctx).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: Theme.of(ctx).colorScheme.primary,
                ),
          ),
        ],
      ),
    ),
  ),
];
}