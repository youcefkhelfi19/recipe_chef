 import 'package:flutter/material.dart';
import 'package:recipe_chef/featured/auth/prenstation/views/splash_screen.dart';

import '../featured/auth/prenstation/views/signin_screen.dart';
import '../featured/main_screen/main_screen.dart';

const String  splash ='/';
 const String  mainRoute ='/main';
 const String categories = '/cats';
 const String details = '/details';
 const String login = '/login';
 const String signin = '/signin';
 const String update = '/update';
 const String popular = '/popular';
 const String recommended = '/recommended';
 const String newest = '/newest';
 const String cart = '/cart';
 Route<dynamic> generateRoutes (RouteSettings routeSettings){
final arg = routeSettings.arguments;
switch(routeSettings.name){
case mainRoute:
return MaterialPageRoute(builder: (c_)=> const MainScreen());
case signin:
return MaterialPageRoute(builder: (c_)=>const SigninScreen());
case popular:
return MaterialPageRoute(builder: (c_)=>const SplashScreen());
case newest:
return MaterialPageRoute(builder: (c_)=>const SplashScreen());
case recommended:
return MaterialPageRoute(builder: (c_)=>const SplashScreen());
case splash:
return MaterialPageRoute(builder: (_)=> const SplashScreen());
case cart:
return MaterialPageRoute(builder: (_)=> const SplashScreen());
case update:
return _errorRoute();
case details:
if(arg is String){
return MaterialPageRoute(builder: (_)=>  SplashScreen());
}
return _errorRoute();
case categories:
if(arg is List){
return MaterialPageRoute(builder: (_)=>  SplashScreen());
}
return _errorRoute();
case login:
return MaterialPageRoute(builder: (_)=> const SplashScreen());
default :
return _errorRoute();

}
}
 Route<dynamic> _errorRoute(){
return MaterialPageRoute(builder: (c_)=>
const Scaffold(
body: Center(
child: Text('Something went wrong'),
),
));
}