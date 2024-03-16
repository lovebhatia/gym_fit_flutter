import 'package:flutter/material.dart';
import 'package:gym_fit/src/providers/auth.dart';
import 'package:gym_fit/src/resources/app_colors.dart';
import 'package:gym_fit/src/screens/home_screen.dart';
import 'package:gym_fit/src/screens/authScreen.dart';
import 'package:gym_fit/src/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    //required this.settingsController,
  });

  //final settingsController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => ScreenUtilInit(
          designSize: Size(360, 640), // Specify your design size
          builder: (BuildContext context, Widget? _) => MaterialApp(
            title: 'healthify',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: AppColors.LIGHT_BLACK),
            ),
            debugShowCheckedModeBanner: false,
            home: auth.isAuth
                ? const HomeScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) => AuthScreen(),
                  ),
            routes: {HomeScreen.routeName: (ctx) => HomeScreen()},
          ),
        ),
      ),
    );
  }
}
