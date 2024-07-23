import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/presentation/cubit/authentication_cubit.dart';
import 'package:laborex_distribution_app/presentation/widgets/custom_button.dart';
import 'package:laborex_distribution_app/presentation/widgets/password_field.dart';
import 'package:laborex_distribution_app/presentation/widgets/phone_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _showPassword = false;
  bool _isLoading = false;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
        'تسجيل الدخول',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
          ),
          SizedBox(height: 30.h),
          PhoneNumberField(controller: _phoneNumberController),
          SizedBox(height: 24.h),
          PasswordField(
            controller: _passwordController,
            showPassword: _showPassword,
            toggleShowPassword: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
          ),
          SizedBox(height: 100.h),
          LoginButton(
            isLoading: _isLoading,
            onPressed: () async {
              try {
                if (!_isLoading && formkey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });
                  await BlocProvider.of<AuthenticationCubit>(context).logUserIn(
                    _phoneNumberController.text,
                    _passwordController.text,
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('حدث خطأ, يرجى المحاولة لاحقا  ${e.toString()}'),
                  ),
                );
              } finally {
                setState(() {
                  _isLoading = false;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
