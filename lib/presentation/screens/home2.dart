// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:laborex_distribution_app/data/models/deliver_order_model.dart';
// import 'package:laborex_distribution_app/presentation/cubit/authentication_cubit.dart';
// import 'package:laborex_distribution_app/presentation/cubit/delivery_orders_cubit.dart';
// import 'package:laborex_distribution_app/presentation/widgets/custom_body.dart';
// import 'package:laborex_distribution_app/presentation/widgets/delivery_order_card.dart';

// class HomeScreen2 extends StatefulWidget {
//   const HomeScreen2({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   late TabController _topTabController;

//   @override
//   void initState() {
//     super.initState();
//     _topTabController = TabController(length: 3, initialIndex: 0, vsync: this);
//     _loadData();
//   }

//   void _loadData() {
//     BlocProvider.of<DeliveryOrdersCubit>(context).getOrders(
//       token: BlocProvider.of<AuthenticationCubit>(context).state.token!,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DeliveryOrdersCubit, DeliveryOrdersState>(
//       builder: (context, state) {
//         if (state is LoadingState) {
//           return const LoadingView();
//         } else if (state is ErrorOccurred) {
//           return ErrorView(
//               errorMessage: state.errorMessage, onRetry: _loadData);
//         } else if (state is DeliveryOrdersLoadedState) {
//           return TabViewsContent(
//             topTabController: _topTabController,
//             stockList: state.stockList,
//             pendingList: state.pendingList,
//             deliveredList: state.deliveredList,
//           );
//         } else {
//           return Container(); // Placeholder for unexpected state
//         }
//       },
//     );
//   }
// }
