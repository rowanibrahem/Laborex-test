import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laborex_distribution_app/core/laborex_title.dart';
import 'package:laborex_distribution_app/presentation/cubit/authentication_cubit.dart';

class CustomDrawer extends StatelessWidget {
  final BuildContext context;

  const CustomDrawer({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () => 
            BlocProvider.of<AuthenticationCubit>(context).logOut(),
          ),
        ],
      ),
    );
  }
}