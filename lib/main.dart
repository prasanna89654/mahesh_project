import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:project/Riverpod/constants.dart';
import 'package:project/view/AdminView/AdminHomePage.dart';
import 'package:project/view/PublicView/appbar.dart';
import 'package:project/view/PublicView/login.dart';
import 'Routes/navigator.dart';
import 'Routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();

  runApp(const ProviderScope(child: MyApp()));
}
//okays

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final router = Routes.getRouter();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generator,
        navigatorKey: AppNavigatorService.navigatorKey,
        home: EasySplashScreen(
          durationInSeconds: 1,
          showLoader: false,
          logo: Image.asset(
            'assets/images/care.png',
            color: Colors.white,
          ),
          backgroundColor: Colors.blue.shade300,
          navigator: selectScreen(),
        ));
  }
}

selectScreen() {
  // final usertype = getStringAsync(userType);
  // print(usertype);
  final token = getStringAsync(accessToken);
  final role = getStringAsync(userType);

  if (token.isEmptyOrNull) {
    return const LoginScreen();
  }

  // } else if (usertype == "Admin") {
  //   // return const AdminHomePage();
  // } else if (usertype == "2") {
  //   return Appbar(
  //     cindex: 0,
  //   );
  // } else {
  //   // return MaintainerDashboard();
  // }
  if (role == "2") {
    return Appbar(
      cindex: 0,
    );
  }
  return const AdminHomePage();
}
