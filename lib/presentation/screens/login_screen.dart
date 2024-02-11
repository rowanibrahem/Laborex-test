import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            TextFormField(
              //TODO add suitable Keyboard Form
              decoration: InputDecoration(
                  labelText: 'رقم التليفون',
                  hintText: "أدخل رقم التليفون",
                  constraints: BoxConstraints(
                    minWidth: 200.w,
                    maxWidth: 360.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(height: 24.h),
            TextFormField(
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
                  )),
            ),
            SizedBox(height: 100.h),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement login functionality
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
              child: const Text('تسجيل الدخول'),
            ),
          ],
        ),
      ),
    );
  }
}
