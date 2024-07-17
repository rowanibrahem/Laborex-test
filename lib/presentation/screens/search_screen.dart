import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/presentation/cubit/delivery_orders_cubit.dart';
import 'package:laborex_distribution_app/presentation/widgets/orders_lists/search_list_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 50.h,
          child: TextField(
            onChanged: (value) {
              EasyDebounce.debounce(
                  'search-orders-debounce', const Duration(milliseconds: 200),
                  () {
                BlocProvider.of<DeliveryOrdersCubit>(context)
                    .filterItems(searchController.text);
              });
            },
            onSubmitted: (value) {
              EasyDebounce.debounce(
                  'search-orders-debounce', const Duration(milliseconds: 200),
                      () {
                    BlocProvider.of<DeliveryOrdersCubit>(context)
                        .filterItems(searchController.text);
                  });
            },
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
              fillColor: const Color(0xFFF3F4F6),
              filled: true,
              // labelText: 'ادخل عدد الأصناف',
              // enabled: (selectedReturn != ReturnType.noReturn),
              hintText: "ابحث برقم الفاتورة",
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
            keyboardType: TextInputType.text,
            maxLines: 1,
          ),
        ),
      ),
      body: const SearchListView(),
    );
  }
}
