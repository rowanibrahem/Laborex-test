import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/data/data%20source/remote_repo.dart';
import 'package:laborex_distribution_app/presentation/screens/login_screen.dart';

import '../../data/models/deliver_order_model.dart';
import '../cubit/authentication_cubit.dart';
import '../cubit/delivery_orders_cubit.dart';
import '../widgets/delivery_order_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late RemoteRepo remoteRepo;
  late Dio _dio;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late TabController _topTabController;
  List<DeliverOrderModel> stockList = [];
  List<DeliverOrderModel> deliveredList = [];
  List<DeliverOrderModel> pendingList = [];
  @override
  initState() {
    super.initState();
    _topTabController = TabController(length: 3, initialIndex: 0, vsync: this);
    if (context.mounted) {
      BlocProvider.of<DeliveryOrdersCubit>(context).getOrders(
        BlocProvider.of<AuthenticationCubit>(context).state.token!,
      );
    }
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

  // Future<void> fetchData(BuildContext ctx) async {
  //   //needed to make sure dio and apiService are initialized first
  //   remoteRepo.token =
  //       BlocProvider.of<AuthenticationCubit>(context).state.token;

  //   Future<void>.delayed(
  //     const Duration(
  //       seconds: 0,
  //     ),
  //   );
  //   try {
  //     List<DeliverOrderModel> data = await remoteRepo.getOrders(
  //       BlocProvider.of<AuthenticationCubit>(context).state.token!,
  //     );
  //     print('Fetched data: $data');
  //     //ORDER_CREATED,
  //     //IN_PROGRESS,
  //     //DELIVERED

  //     stockList = data
  //         .where((element) =>
  //             element.orderStatus ==
  //             'ORDER_CREATED') // replace 'stock' with the correct status for each list
  //         .toList();
  //     pendingList = data
  //         .where((element) =>
  //             element.orderStatus ==
  //             'IN_PROGRESS') // replace 'pending' with the correct status for each list
  //         .toList();
  //     deliveredList = data
  //         .where((element) =>
  //             element.orderStatus ==
  //             'DELIVERED') // replace 'delivered' with the correct status for each list
  //         .toList();

  //     setState(() {}); // Trigger a rebuild with the fetched data
  //   } catch (error) {
  //     // Handle errors
  //     print('Error: $error');
  //   }
  // }

  Future<void> refreshData(BuildContext ctx) async {
    Future<void>.delayed(const Duration(seconds: 0));
    BlocProvider.of<DeliveryOrdersCubit>(ctx).getOrders(
      BlocProvider.of<AuthenticationCubit>(ctx).state.token!,
    );
  }

  @override
  Widget build(BuildContext context) {
    stockList =
        BlocProvider.of<DeliveryOrdersCubit>(context, listen: true).stockList;
    deliveredList = BlocProvider.of<DeliveryOrdersCubit>(context, listen: true)
        .deliveredList;
    pendingList =
        BlocProvider.of<DeliveryOrdersCubit>(context, listen: true).pendingList;
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

    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (listenerCtx, state) {
        if (state is LoggedOut) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (builderContext) => const LoginScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.h,
          elevation: 4.r,
          actions: laborexTitle,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: TabBar(
              controller: _topTabController,
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
        //TODO add drawer
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(),
                child: Column(
                  children: laborexTitle,
                ),
              ),
              ListTile(
                title: const Text('تسجيل الخروج'),
                onTap: () {
                  BlocProvider.of<AuthenticationCubit>(context).logOut();
                },
              ),
              // ListTile(
              //   title: const Text('check token'),
              //   onTap: () {
              //     var token =
              //         BlocProvider.of<AuthenticationCubit>(context).state.token;

              //     log("token is $token");
              //     BlocProvider.of<AuthenticationCubit>(context).token;
              //   },
              // ),
            ],
          ),
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          color: Colors.white,
          backgroundColor: Colors.blue,
          onRefresh: () => refreshData(context),
          child: TabBarView(
            controller: _topTabController,
            children: [
              if (BlocProvider.of<DeliveryOrdersCubit>(context, listen: true)
                      .state
                      .status ==
                  "loading") ...[
                const Center(
                  child: CircularProgressIndicator(),
                ),
                const Center(
                  child: CircularProgressIndicator(),
                ),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ] else
                //*
                ...[
                (stockList.isEmpty)
                    ? const Center(
                        child: Text('لا يوجد طلبات هنا'),
                      )
                    : ListView.builder(
                        itemCount: stockList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DeliveryOrderCard(
                            deliveryOrder: stockList[index],
                          );
                        },
                      ),
                (pendingList.isEmpty)
                    ? const Center(
                        child: Text('لا يوجد طلبات هنا'),
                      )
                    : ListView.builder(
                        itemCount: pendingList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DeliveryOrderCard(
                            deliveryOrder: pendingList[index],
                          );
                        },
                      ),
                (deliveredList.isEmpty)
                    ? const Center(
                        child: Text('لا يوجد طلبات هنا'),
                      )
                    : ListView.builder(
                        itemCount: deliveredList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DeliveryOrderCard(
                            deliveryOrder: deliveredList[index],
                          );
                        },
                      ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
