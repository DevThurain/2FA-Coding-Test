import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import 'package:two_fa/core/router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 930),
      minTextAdapt: true,

      builder: (_, child) {
        return ToastificationWrapper(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            routerConfig: router,
            theme: ThemeData(textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.green)),
          ),
        );
      },
    );
  }
}
