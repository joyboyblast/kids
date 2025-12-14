import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kids_learning/routes/app_pages.dart';
import 'package:kids_learning/utils/themes/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        title: 'Kids Learning',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.baseColor,
          colorScheme: .fromSeed(
            seedColor: AppColors.baseColor,
            primary: AppColors.primary1,
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}
