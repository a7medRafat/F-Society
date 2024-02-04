import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fsociety/features/layout/presentation/screens/App_Layout.dart';
import '../../core/navigation/navigation.dart';
import '../../core/shared_preferances/cache_helper.dart';
import '../authentication/presentation/screens/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3), () {
      if (CacheHelper.getData(key: 'uid') == null) {
        Navigation().navigateAndFinish(context, LoginScreen());
      } else {
        Navigation().navigateAndFinish(context, const AppLayout());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/ffsplash.png', fit: BoxFit.cover),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'from',
                    style: TextStyle(
                        fontSize: 11, color: Colors.grey.withOpacity(0.4)),
                  ),
                  Text(
                    'Flutter',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        foreground: Paint()
                          ..shader = const LinearGradient(colors: [
                            Color(0xffF9CE34),
                            Color(0xffee2a7b),
                            Color(0xff6228d7)
                          ]).createShader(
                              const Rect.fromLTWH(150, 20, 150, 70.0))),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
