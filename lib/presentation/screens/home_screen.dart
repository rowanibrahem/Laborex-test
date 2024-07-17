import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laborex_distribution_app/presentation/screens/login_screen.dart';
import 'package:laborex_distribution_app/presentation/widgets/custom_app_bar.dart';
import 'package:laborex_distribution_app/presentation/widgets/custom_drawer.dart';
import 'package:laborex_distribution_app/presentation/widgets/home_body.dart';

import '../../data/data source/remote_repo.dart';
import '../cubit/authentication_cubit.dart';
import '../cubit/delivery_orders_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late RemoteRepo remoteRepo;

  late TabController _topTabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();


  @override
  initState() {
    super.initState();
    _topTabController = TabController(length: 3, initialIndex: 0, vsync: this);
    if (context.mounted) {
      BlocProvider.of<DeliveryOrdersCubit>(context).fetchOrders(
        // token: accessToken,
        token: BlocProvider.of<AuthenticationCubit>(context).state.token!,
        tenantUUID: BlocProvider.of<AuthenticationCubit>(context).state.tenantUUID!,
      );
    }
  }

  @override
  void dispose() {
    _topTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        key: _key,
        appBar: LaborexAppBar(
          context: context,
          topTabController: _topTabController, scaffoldKey: _key,
        ),
        drawer: CustomDrawer(
          context: context,
        ),
        body: HomeBody(
          topTabController: _topTabController,
        ),
      ),
    );
  }
}
