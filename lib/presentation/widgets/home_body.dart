import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laborex_distribution_app/presentation/cubit/delivery_orders_cubit.dart';
import 'package:laborex_distribution_app/presentation/widgets/tab_views_content.dart';

class HomeBody extends StatelessWidget {
  final TabController topTabController;
  const HomeBody({
    super.key,
    required this.topTabController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryOrdersCubit, DeliveryOrdersState>(
      listener: (context, state) {
        // This part is where error messages and backend responses are handled

        if (state is ErrorOccurredState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.customError?.errorMessage ?? "حدث خطأ"),
            ),
          );
          BlocProvider.of<DeliveryOrdersCubit>(context).errorHandled();
        } else if (state is ShowMessageState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
            ),
          );
        } else if (state is SentReturnRequest) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    icon: Image.asset('assets/img.png'),
                    title: Text(state.message!),
                  ));
        }
      },
      builder: (context, state) {
        if (state.status == "loading") {
          return TabViewsContent.loading(
            topTabController: topTabController,
          );
        } else {
          return TabViewsContent(
            topTabController: topTabController,
          );
        }
      },
    );
  }
}
