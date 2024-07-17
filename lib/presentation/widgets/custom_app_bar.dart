import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/presentation/screens/search_screen.dart';

import '../../core/laborex_title.dart';

class LaborexAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final TabController topTabController;
  final GlobalKey<ScaffoldState> scaffoldKey; // Create a key

   const LaborexAppBar({
    super.key,
    required this.context,
    required this.topTabController,
    required this.scaffoldKey
  });

  @override
  Size get preferredSize => Size.fromHeight(200.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4.r,
      leadingWidth: double.infinity,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
           IconButton(onPressed: ()=>scaffoldKey.currentState!.openDrawer(), icon:const Icon(Icons.menu_outlined)),
          IconButton(icon:const Icon(Icons.search),onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchScreen())),),

        ],
      ),
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
