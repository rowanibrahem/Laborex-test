import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/data/data%20source/api.dart';
import 'package:laborex_distribution_app/data/models/deliver_order_state/deliver_order_state.dart';
import 'package:laborex_distribution_app/data/data%20source/repo.dart';

import '../widgets.dart/delivery_order_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late TabController topTabController;
  List<DeliverOrderStateModel> stockList = [];
  List<DeliverOrderStateModel> deliveredList = [];
  List<DeliverOrderStateModel> pendingList = [];
  // final DeliveryOrderRepository _deliveryOrderRepository =
  //     DeliveryOrderRepository();
  @override
  initState() {
    super.initState();
    topTabController = TabController(length: 3, initialIndex: 0, vsync: this);
    fetchData();
  }

  // Future<void> fetchData() async {
  //   try {
  //     List<DeliverOrderStateModel> allDeliveryOrders =
  //         await _deliveryOrderRepository.getDeliveryOrders();

  //     stockList = allDeliveryOrders
  //         .where((element) =>
  //             element.orderStatus == const DeliverOrderStateModel().orderStatus)
  //         .toList();
  //     deliveredList = allDeliveryOrders
  //         .where((element) => element.orderStatus == const DeliverOrderStateModel().orderStatus)
  //         .toList();
  //     pendingList = allDeliveryOrders
  //         .where((element) => element.orderStatus == const DeliverOrderStateModel().orderStatus)
  //         .toList();

  //     setState(() {}); // Trigger a rebuild with the fetched data
  //   } catch (e) {
  //     // Handle errors
  //   }
  // }

  Future<void> fetchData() async {
    final apiService =
        ApiService('https://dms.ebdaa-business.com/api/v1/order/driver-orders');
    try {
      List<DeliverOrderStateModel> data = await apiService.fetchDataFromServer(
          'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiRFJJVkVSIiwidXNlcl9pZCI6MywidXNlcm5hbWUiOiJkcml2ZXIgMSIsImlzcyI6IkRNU19BUFAiLCJhdWQiOiJETVNfQURNSU5JU1RSQVRJT04iLCJzdWIiOiIwNDQ0NDQ0NDQ0NCIsImlhdCI6MTcwOTU1NzY4MSwiZXhwIjoxNzEyMTQ5NjgxfQ.6Vd8IBY3tJZZhbofzbM-4rMQ5KtZ8JLAJNMQrcnXzGI');
      print('Fetched data: $data');
      //ORDER_CREATED,
      //IN_PROGRESS,
      //DELIVERED
      stockList = data
          .where((element) =>
              element.orderStatus ==
              'ORDER_CREATED') // replace 'stock' with the correct status for each list
          .toList();
      pendingList = data
          .where((element) =>
              element.orderStatus ==
              'IN_PROGRESS') // replace 'pending' with the correct status for each list
          .toList();
      deliveredList = data
          .where((element) =>
              element.orderStatus ==
              'DELIVERED') // replace 'delivered' with the correct status for each list
          .toList();

      setState(() {}); // Trigger a rebuild with the fetched data
    } catch (error) {
      // Handle errors
      print('Error: $error');
    }
  }

  Future<void> refreshData() async {
    Future<void>.delayed(const Duration(seconds: 3));
    await fetchData();
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: Colors.blue,
        onRefresh: refreshData,
        child: TabBarView(
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
      ),
    );
  }
}
