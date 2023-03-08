import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../services/locator.dart';
import '../../../../utils/app_routes.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    opacityHandler();
    super.initState();
  }

   opacityHandler(){
     Future.delayed(const Duration(milliseconds: 0), () {
       setState(() {
         opacityLevel = 1.0;
       });
       nextRoute();
     });
   }
  nextRoute() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      getIt.get<GetStorage>().read('token')==null ?Navigator.pushReplacementNamed(context, signin):Navigator.pushReplacementNamed(context, mainRoute);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: opacityLevel,
          duration: const Duration(milliseconds: 2000),
          child: Image.asset(
            'assets/images/logo.png', height: 100, width: 100,),
        ),
      ),
    );
  }
}
