import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/core/laborex_title.dart';
import 'package:laborex_distribution_app/presentation/cubit/authentication_cubit.dart';
import 'package:laborex_distribution_app/presentation/widgets/confirmation_dialog.dart';

class CustomDrawer extends StatelessWidget {
  final BuildContext context;

  const CustomDrawer({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(),
            child: LaborexTitle(),
          ),
          SizedBox(
            height: 630.h,
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              'تسجيل الخروج',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () => showDialog(
                context: context,
                builder: (context) => ConfirmationDialog(
                    text: 'هل أنت متأكد من انك تريد تسجيل الخروج',
                    confirmationFunction: () =>
                        BlocProvider.of<AuthenticationCubit>(context)
                            .logOut())),
          ),
        ],
      ),
    );
  }
}
