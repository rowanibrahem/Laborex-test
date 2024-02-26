import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/delivery_order.dart';
import '../widgets.dart/delivery_order_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController topTabController;

  @override
  initState() {
    super.initState();
    topTabController = TabController(length: 3, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final laborexTitle = [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
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

    final deliveryOrders = [
      DeliveryOrder(
        orderId: "112213115",
        pharmacyName: "صيدلية بيراميدز",
        itemsCount: 2,
        billNumber: 1,
        totalAmount: 22.5,
        status: DeliveryOrderStatus.pending,
      ),
      DeliveryOrder(
        orderId: "264664",
        pharmacyName: "صيدلية بيراميدز",
        itemsCount: 3,
        billNumber: 2,
        totalAmount: 33.5,
        status: DeliveryOrderStatus.inStock,
      ),
      DeliveryOrder(
        orderId: "355531",
        pharmacyName: "صيدلية بيراميدز",
        itemsCount: 4,
        billNumber: 3,
        totalAmount: 44.5,
        status: DeliveryOrderStatus.delivered,
      ),
      DeliveryOrder(
        orderId: "6515513",
        pharmacyName: "Pasta",
        itemsCount: 4,
        billNumber: 3,
        totalAmount: 44.5,
        status: DeliveryOrderStatus.delivered,
      ),
      DeliveryOrder(
        orderId: "315151515",
        pharmacyName: "صيدلية بيراميدز",
        itemsCount: 4,
        billNumber: 3,
        totalAmount: 44.5,
        status: DeliveryOrderStatus.delivered,
      ),
    ];
    final stockList = deliveryOrders
        .where((element) => element.status == DeliveryOrderStatus.inStock)
        .toList();
    final deliverdList = deliveryOrders
        .where((element) => element.status == DeliveryOrderStatus.delivered)
        .toList();
    final pendingList = deliveryOrders
        .where((element) => element.status == DeliveryOrderStatus.pending)
        .toList();

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
            itemCount: deliverdList.length,
            itemBuilder: (BuildContext context, int index) {
              return DeliveryOrderCard(
                deliveryOrder: deliverdList[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
