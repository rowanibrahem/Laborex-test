import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/core/laborex_title.dart';
import 'package:laborex_distribution_app/data/data%20source/remote_repo.dart';
import 'package:laborex_distribution_app/presentation/screens/login_screen.dart';
import 'package:laborex_distribution_app/presentation/widgets/custom_bottom_sheet.dart';
import 'package:laborex_distribution_app/presentation/widgets/info_dialog.dart';

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
          token: BlocProvider.of<AuthenticationCubit>(context).state.token!,
          showSnackBar: showSnackBar);
    }
  }

  void showSnackBar(String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  Future<void> refreshData(BuildContext ctx) async {
    Future<void>.delayed(const Duration(seconds: 0));
    BlocProvider.of<DeliveryOrdersCubit>(ctx).getOrders(
      token: BlocProvider.of<AuthenticationCubit>(ctx).state.token!,
      showSnackBar: showSnackBar,
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
          actions: laborexTitle(context),
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
                  children: laborexTitle(context),
                ),
              ),
              ListTile(
                title: const Text('تسجيل الخروج'),
                onTap: () {
                  BlocProvider.of<AuthenticationCubit>(context).logOut();
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
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
                  ? RefreshIndicator(
                      onRefresh: () => refreshData(context),
                      child: Stack(
                        children: <Widget>[
                          ListView(),
                          const Center(
                            child: Text('لا يوجد طلبات هنا'),
                          )
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => refreshData(context),
                      child: ListView.builder(
                        itemCount: stockList.length,
                        itemBuilder: (_, int index) {
                          return DeliveryOrderCard(
                            deliveryOrder: stockList[index],
                            onTapAction: (itemId) =>
                                BlocProvider.of<DeliveryOrdersCubit>(context)
                                    .inStockAction(
                              token:
                                  BlocProvider.of<AuthenticationCubit>(context)
                                      .state
                                      .token!,
                              id: itemId,
                              showSnackBar: showSnackBar,
                            ),
                          );
                        },
                      ),
                    ),
              (pendingList.isEmpty)
                  ? RefreshIndicator(
                      onRefresh: () => refreshData(context),
                      child: Stack(
                        children: <Widget>[
                          ListView(),
                          const Center(
                            child: Text('لا يوجد طلبات هنا'),
                          )
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => refreshData(context),
                      child: ListView.builder(
                        itemCount: pendingList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DeliveryOrderCard(
                            deliveryOrder: pendingList[index],
                            onTapAction: (itemId) {
                              Scaffold.of(context).showBottomSheet(
                                (context) {
                                  return CustomBottomSheet(
                                    onConfirm: (
                                      String paymentType,
                                      String returnType,
                                      String description,
                                    ) {
                                      BlocProvider.of<DeliveryOrdersCubit>(
                                              context)
                                          .deliveredAction(
                                        token: BlocProvider.of<
                                                AuthenticationCubit>(context)
                                            .state
                                            .token!,
                                        id: itemId,
                                        paymentType: paymentType,
                                        returnType: returnType,
                                        description: description,
                                        showSnackBar: showSnackBar,
                                      );
                                    },
                                  );
                                },

                              );
                            },
                          );
                        },
                      ),
                    ),
              (deliveredList.isEmpty)
                  ? RefreshIndicator(
                      onRefresh: () => refreshData(context),
                      child: Stack(
                        children: <Widget>[
                          ListView(),
                          const Center(
                            child: Text('لا يوجد طلبات هنا'),
                          )
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => refreshData(context),
                      child: ListView.builder(
                        itemCount: deliveredList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DeliveryOrderCard(
                            deliveryOrder: deliveredList[index],
                            //TODO
                            onTapAction: (itemId) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return InfoDialog(
                                      deliveryOrder: deliveredList[index],
                                    );
                                    //   return const AlertDialog(
                                    //     title: Text("Success"),
                                    //     content: Text("Saved successfully"),
                                    //   );
                                  });
                            },
                          );
                        },
                      ),
                    ),
            ]
          ],
        ),
      ),
    );
  }
}
