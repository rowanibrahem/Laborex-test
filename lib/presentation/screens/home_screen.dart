import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/domain/repo.dart';

import '../../data/models/delivery_order.dart';
import '../widgets.dart/delivery_order_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController topTabController;
  List<DeliveryOrderModel> stockList = [];
  List<DeliveryOrderModel> deliveredList = [];
  List<DeliveryOrderModel> pendingList = [];
  final DeliveryOrderRepository _deliveryOrderRepository =
      DeliveryOrderRepository();
  @override
  initState() {
    super.initState();
    topTabController = TabController(length: 3, initialIndex: 0, vsync: this);
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<DeliveryOrderModel> allDeliveryOrders =
          await _deliveryOrderRepository.getDeliveryOrders();

      stockList = allDeliveryOrders
          .where((element) => element.status == DeliveryOrderStatus.inStock)
          .toList();
      deliveredList = allDeliveryOrders
          .where((element) => element.status == DeliveryOrderStatus.delivered)
          .toList();
      pendingList = allDeliveryOrders
          .where((element) => element.status == DeliveryOrderStatus.pending)
          .toList();

      setState(() {}); // Trigger a rebuild with the fetched data
    } catch (e) {
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    final laborexTitle = [
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
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Text(
                'Pharma',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
        ),
      ),
    ];

    








    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        elevation: 4.r,
        actions: laborexTitle,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
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
                // text: 'جاري التوصيل',
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
      ),
      drawer: const Drawer(),
      body: TabBarView(
        controller: topTabController,
        children: [
          //*

          ListView.builder(
            itemCount: stockList.length,
            itemBuilder: (BuildContext context, int index) {
              return DeliveryOrderCard(
                deliveryOrder: stockList[index],
              );
            },
          ),
          ListView.builder(
            itemCount: pendingList.length,
            itemBuilder: (BuildContext context, int index) {
              return DeliveryOrderCard(
                deliveryOrder: pendingList[index],
              );
            },
          ),
          ListView.builder(
            itemCount: deliveredList.length,
            itemBuilder: (BuildContext context, int index) {
              return DeliveryOrderCard(
                deliveryOrder: deliveredList[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
