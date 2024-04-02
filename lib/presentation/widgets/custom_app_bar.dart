import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/laborex_title.dart';

class LaborexAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final TabController topTabController;

  const LaborexAppBar({
    super.key,
    required this.context,
    required this.topTabController,
  });

  @override
  Size get preferredSize => Size.fromHeight(200.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4.r,
      actions: const [LaborexTitle()],
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: TabBar(
          controller: topTabController,
          tabs: [
            Tab(
              child: Text(
                'المخزن',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Tab(
              child: Text(
                "جاري التوصيل",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Tab(
              child: Text(
                "مكتمل",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
