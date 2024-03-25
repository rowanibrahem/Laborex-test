import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/core/laborex_title.dart';
import 'package:laborex_distribution_app/data/data%20source/remote_repo.dart';
import 'package:laborex_distribution_app/presentation/screens/login_screen.dart';
import 'package:laborex_distribution_app/presentation/widgets/custom_appbar.dart';
import 'package:laborex_distribution_app/presentation/widgets/custom_body.dart';
import 'package:laborex_distribution_app/presentation/widgets/custom_bottom_sheet.dart';
import 'package:laborex_distribution_app/presentation/widgets/custom_drawer.dart';
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
        appBar: LaborexAppBar(context: context,topTabController: _topTabController,),
        
        drawer:
        CustomDrawer(context: context),
         
        
        body: TabViewsBuilder(
          topTabController: _topTabController,
          refreshdata: refreshData(context), 
          showsnackbar: showSnackBar,
          
          
         
      )
      )
  
    );
  }
  
}
