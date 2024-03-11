import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/presentation/screens/home_screen.dart';

import '../cubit/authentication_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  bool _isLoading = false;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      _phoneNumberController.dispose();
      _passwordController.dispose();
      super.dispose();
    }

    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (listenerCtx, state) {
        if (state is LoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
        if (state is LoadingState) {
          setState(() {
            _isLoading = true;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.h,
          title: Text(
            'تسجيل الدخول',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
          ),
        ),
        body: Center(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'رقم التليفون',
                    hintText: "أدخل رقم التليفون",
                    constraints: BoxConstraints(
                      minWidth: 200.w,
                      maxWidth: 360.w,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك ادخل رقم الهاتف';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    suffix: InkWell(
                      child: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                    labelText: 'ادخل كلمة السر',
                    hintText: "كلمة السر",
                    constraints: BoxConstraints(
                      maxWidth: 360.w,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك ادخل كلمة السر ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 100.h),
                ElevatedButton(
                  onPressed: (_isLoading)
                      ? null
                      : () {
                          if (formkey.currentState!.validate()) {
                            BlocProvider.of<AuthenticationCubit>(context)
                                .logUserIn(
                              _phoneNumberController.text,
                              _passwordController.text,
                            );
                          }
                        },
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        fixedSize: MaterialStateProperty.all(
                          Size(390.w, 50.h),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                  child: (_isLoading)
                      ? const CircularProgressIndicator()
                      : const Text('تسجيل الدخول'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
