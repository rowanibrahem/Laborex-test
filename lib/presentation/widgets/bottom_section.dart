import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSection extends StatelessWidget {
  final String title;
  final String subtitle;
  const BottomSection({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xbb696969),
                fontSize: 14.sp,
              ),
        ),
        SizedBox(height: 8.h),
        Text(subtitle),
      ],
    );
  }
}
